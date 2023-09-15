import 'dart:io';

import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:gesture_password_widget/gesture_password_widget.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:sp_util/sp_util.dart';

class AuthPage extends StatefulWidget {
  final bool launch;
  final bool launchAccountPage;
  AuthPage({this.launch = true, this.launchAccountPage = false});
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool canCheckBiometrics = false;
  DateTime? lastPopTime;
  BiometricType biometricsType = BiometricType.fingerprint;
  int errorCount = 0;
  String password = "";
  @override
  void initState() {
    Utils.isAuthPage = true;
    getData();
    super.initState();
  }

  Map<BiometricType, String> biometricTypeName = {
    BiometricType.face: "FaceId",
    BiometricType.fingerprint: "指纹",
    BiometricType.iris: "人脸",
  };
  @override
  void dispose() {
    Utils.isAuthPage = false;
    auth.stopAuthentication();
    super.dispose();
  }

  getData() async {
    password = SpUtil.getString("gesture_password", defValue: "")!;
    bool launchAuthBiometrics = SpUtil.getBool("launch_auth_biometrics", defValue: false)!;
    if (launchAuthBiometrics) {
      canCheckBiometrics = await auth.canCheckBiometrics;
      setState(() {});
      if (canCheckBiometrics) {
        List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
        if (Platform.isIOS) {
          setState(() {
            if (availableBiometrics.contains(BiometricType.face)) {
              biometricsType = BiometricType.face;
            } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
              biometricsType = BiometricType.fingerprint;
            } else if (availableBiometrics.contains(BiometricType.iris)) {
              biometricsType = BiometricType.iris;
            }
          });
        }
      }
      if (Platform.isIOS) {
        await Future.delayed(Duration(milliseconds: 300));
      }
      try {
        bool didAuthenticate = await auth.authenticate(
          options: AuthenticationOptions(
            biometricOnly: true,
            sensitiveTransaction: false,
          ),
          authMessages: [
            IOSAuthMessages(
              lockOut: "认证失败次数过多，请稍后再试",
              goToSettingsButton: "设置",
              goToSettingsDescription: "系统未设置${biometricTypeName[biometricsType]}，点击设置按钮前往系统设置页面",
              cancelButton: "取消",
            ),
            AndroidAuthMessages(
              biometricNotRecognized: "系统未设置指纹",
              biometricRequiredTitle: "请触摸指纹传感器",
              signInTitle: "验证指纹",
              cancelButton: "取消",
              biometricHint: "如果验证失败5次请等待30秒后重试",
              goToSettingsButton: "设置",
              goToSettingsDescription: "点击设置按钮前往系统指纹设置页面",
              biometricSuccess: "指纹验证成功",
            )
          ],
          localizedReason: '请触摸指纹传感器',
        );
        auth.stopAuthentication();
        if (didAuthenticate) {
          //验证成功
          Utils.vibrate(FeedbackType.light);
          if (widget.launch) {
            Navigator.of(context).pushReplacementNamed("/login");
          } else {
            Navigator.of(context).pop();
          }
        } else {
          Utils.vibrate(FeedbackType.warning);
          Utils.toast("${biometricTypeName[biometricsType]}验证失败，请使用图形密码登录");
        }
      } on PlatformException catch (e) {
        Utils.vibrate(FeedbackType.warning);
        if (e.code == auth_error.notAvailable) {
          Utils.toast("${biometricTypeName[biometricsType]}验证不可用，请使用图形密码登录");
        } else if (e.code == auth_error.passcodeNotSet) {
          Utils.toast("系统未设置密码");
        } else if (e.code == auth_error.lockedOut) {
          Utils.toast("认证失败次数过多，请使用图形密码登录");
        } else {
          Utils.toast(e.message ?? "认证失败");
        }
      }
    }
  }

  Future<bool> onWillPop() {
    Utils.vibrate(FeedbackType.light);
    if (lastPopTime == null || DateTime.now().difference(lastPopTime!) > Duration(seconds: 2)) {
      lastPopTime = DateTime.now();
      Utils.toast('再按一次退出${Utils.appName}');
    } else {
      lastPopTime = DateTime.now();
      // 退出app
      SystemNavigator.pop();
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('安全验证'),
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                "请绘制解锁图案",
                style: TextStyle(fontSize: 26),
              ),
              SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.9,
                  child: GesturePasswordWidget(
                    onComplete: (s) {
                      if (s.join(",") == password) {
                        //密码验证通过
                        if (widget.launch) {
                          if (widget.launchAccountPage) {
                            Navigator.of(context).pushReplacementNamed("/accounts");
                          } else {
                            Navigator.of(context).pushReplacementNamed("/login");
                          }
                        } else {
                          Navigator.of(context).pop();
                        }
                      } else {
                        //密码验证不通过
                        if (errorCount < 2) {
                          Utils.toast("密码错误");
                          Utils.vibrate(FeedbackType.warning);
                        } else if (errorCount < 5) {
                          errorCount++;
                          Utils.toast("密码错误，连续错误5次将清空登录历史");
                          Utils.vibrate(FeedbackType.warning);
                        } else {
                          Utils.toast("密码错误已达5次");
                          Utils.vibrate(FeedbackType.warning);
                          SpUtil.remove("servers");
                          SpUtil.remove("https");
                          SpUtil.remove("host");
                          SpUtil.remove("port");
                          SpUtil.remove("account");
                          SpUtil.remove("remember_password");
                          SpUtil.remove("auto_login");
                          SpUtil.remove("check_ssl");
                          Navigator.of(context).pushReplacementNamed("/login");
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
