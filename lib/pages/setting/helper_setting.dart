import 'dart:io';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/pages/common/gesture_password.dart';
import 'package:dsm_helper/pages/setting/about.dart';
import 'package:dsm_helper/pages/setting/vip.dart';
import 'package:dsm_helper/pages/setting/logout.dart';
import 'package:dsm_helper/providers/setting.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/util/neu_picker.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth_android/local_auth_android.dart';

import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

class HelperSetting extends StatefulWidget {
  @override
  _HelperSettingState createState() => _HelperSettingState();
}

class _HelperSettingState extends State<HelperSetting> {
  final LocalAuthentication auth = LocalAuthentication();
  bool launchAuth = false;
  bool password = false;
  bool biometrics = false;
  bool canCheckBiometrics = false;
  bool videoPlayer = false;
  bool launchAccountPage = false;
  BiometricType biometricsType = BiometricType.fingerprint;

  Map<BiometricType, String> biometricTypeName = {
    BiometricType.face: "FaceId",
    BiometricType.fingerprint: "指纹",
    BiometricType.iris: "人脸",
  };
  @override
  void initState() {
    initAuth();
    super.initState();
  }

  initAuth() async {
    videoPlayer = SpUtil.getBool("video_player", defValue: false)!;
    launchAuth = SpUtil.getBool("launch_auth", defValue: false)!;
    password = SpUtil.getBool("launch_auth_password", defValue: false)!;
    biometrics = SpUtil.getBool("launch_auth_biometrics", defValue: false)!;
    launchAccountPage = SpUtil.getBool("launch_account_page", defValue: false)!;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("助手设置"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                Util.vibrateOn = !Util.vibrateOn;
                SpUtil.putBool("vibrate_on", Util.vibrateOn);
                if (Util.vibrateOn) {
                  Util.vibrate(FeedbackType.light);
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/vibrate.png",
                          width: 30,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "震动",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        if (Util.vibrateOn)
                          Icon(
                            CupertinoIcons.checkmark_alt,
                            color: Color(0xffff9813),
                          ),
                      ],
                    ),
                    if (Util.vibrateOn)
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Util.vibrateNormal = !Util.vibrateNormal;
                                    SpUtil.putBool("vibrate_warning", Util.vibrateNormal);
                                    if (Util.vibrateNormal) {
                                      Util.vibrate(FeedbackType.light);
                                    }
                                  });
                                },
                                child: Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  child: Row(
                                    children: [
                                      Text(
                                        "基础操作震动",
                                        style: TextStyle(fontSize: 16, height: 1.6),
                                      ),
                                      Spacer(),
                                      if (Util.vibrateNormal)
                                        Icon(
                                          CupertinoIcons.checkmark_alt,
                                          color: Color(0xffff9813),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Util.vibrateWarning = !Util.vibrateWarning;
                                    SpUtil.putBool("vibrate_warning", Util.vibrateWarning);
                                    if (Util.vibrateWarning) {
                                      Util.vibrate(FeedbackType.warning);
                                    }
                                  });
                                },
                                child: Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  child: Row(
                                    children: [
                                      Text(
                                        "敏感操作震动",
                                        style: TextStyle(fontSize: 16, height: 1.6),
                                      ),
                                      Spacer(),
                                      if (Util.vibrateWarning)
                                        Icon(
                                          CupertinoIcons.checkmark_alt,
                                          color: Color(0xffff9813),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                videoPlayer = !videoPlayer;
                SpUtil.putBool("video_player", videoPlayer);
              });
            },
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/player.png",
                    width: 25,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "始终使用第三方播放器",
                    style: TextStyle(fontSize: 16, height: 1.6),
                  ),
                  Spacer(),
                  if (videoPlayer)
                    Icon(
                      CupertinoIcons.checkmark_alt,
                      color: Color(0xffff9813),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Consumer<SettingProvider>(builder: (context, settingProvider, _) {
            return GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return NeuPicker(
                      List.generate(20, (index) => "${index + 1}"),
                      value: List.generate(20, (index) => index + 1).indexOf(settingProvider.refreshDuration),
                      onConfirm: (v) {
                        settingProvider.setRefreshDuration(v + 1);
                      },
                    );
                  },
                );
              },
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/player.png",
                      width: 25,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "控制台/资源监控更新频率",
                      style: TextStyle(fontSize: 16, height: 1.6),
                    ),
                    Spacer(),
                    Text("${settingProvider.refreshDuration}秒")
                  ],
                ),
              ),
            );
          }),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                launchAccountPage = !launchAccountPage;
                SpUtil.putBool("launch_account_page", launchAccountPage);
              });
            },
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/change.png",
                    width: 25,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "启动时默认进入选择账号页面",
                    style: TextStyle(fontSize: 16, height: 1.6),
                  ),
                  Spacer(),
                  if (launchAccountPage)
                    Icon(
                      CupertinoIcons.checkmark_alt,
                      color: Color(0xffff9813),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                launchAuth = !launchAuth;
                SpUtil.putBool("launch_auth", launchAuth);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/safe.png",
                          width: 30,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "启动密码",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        if (launchAuth)
                          Icon(
                            CupertinoIcons.checkmark_alt,
                            color: Color(0xffff9813),
                          ),
                      ],
                    ),
                    if (launchAuth)
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (password) {
                                      setState(() {
                                        password = false;
                                        SpUtil.putBool("launch_auth_password", false);
                                        biometrics = false;
                                        SpUtil.putBool("launch_auth_biometrics", false);
                                      });
                                    } else {
                                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                                        return GesturePasswordPage();
                                      })).then((res) {
                                        if (res != null && res) {
                                          setState(() {
                                            password = true;
                                            SpUtil.putBool("launch_auth_password", password);
                                          });
                                        }
                                      });
                                    }
                                    // password = !password;
                                    // Util.setStorage("launch_password", password ? "1" : "0");
                                  });
                                },
                                child: Container(
                                  // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "图形密码",
                                            style: TextStyle(fontSize: 16, height: 1.6),
                                          ),
                                          Spacer(),
                                          if (password)
                                            Icon(
                                              CupertinoIcons.checkmark_alt,
                                              color: Color(0xffff9813),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (canCheckBiometrics) ...[
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (biometrics == false) {
                                      if (password == false) {
                                        Util.vibrate(FeedbackType.warning);
                                        Util.toast("请先开启图形密码后再开启指纹");
                                        return;
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
                                        setState(() {
                                          biometrics = didAuthenticate;
                                          SpUtil.putBool("launch_auth_biometrics", biometrics);
                                        });
                                      } on PlatformException catch (e) {
                                        if (e.code == auth_error.notAvailable) {
                                          Util.toast("生物验证不可用");
                                        } else if (e.code == auth_error.passcodeNotSet) {
                                          Util.toast("系统未设置密码");
                                        } else if (e.code == auth_error.lockedOut) {
                                          Util.toast("认证失败次数过多，请稍后再试");
                                        } else {
                                          Util.toast(e.message ?? "认证失败");
                                        }
                                      }
                                    } else {
                                      setState(() {
                                        biometrics = false;
                                        SpUtil.putBool("launch_auth_biometrics", biometrics);
                                      });
                                    }

                                    // setState(() {
                                    //   biometrics = !biometrics;
                                    //   Util.setStorage("launch_biometrics", biometrics ? "1" : "0");
                                    // });
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${biometricTypeName[biometricsType]}验证",
                                              style: TextStyle(fontSize: 16, height: 1.6),
                                            ),
                                            Spacer(),
                                            if (biometrics)
                                              Icon(
                                                CupertinoIcons.checkmark_alt,
                                                color: Color(0xffff9813),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (!Util.notReviewAccount) ...[
            SizedBox(
              height: 20,
            ),
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return Logout();
                    },
                    settings: RouteSettings(name: "logout")));
              },
              // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(20),
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),

              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/logout.png",
                    width: 25,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "注销账号",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
            onPressed: () {
              var hide = showWeuiLoadingToast(context: context);
              clearDiskCachedImages();
              hide();
              Util.toast("图片缓存清理完成");
            },
            // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(20),
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/clear_cache.png",
                  width: 25,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "清理图片缓存",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return About();
                  },
                  settings: RouteSettings(name: "about")));
            },
            // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(20),
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/info_liner.png",
                  width: 25,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "关于${Util.appName}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (Util.notReviewAccount)
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return Vip();
                    },
                    settings: RouteSettings(name: "vip")));
              },
              // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(20),
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),

              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/no_ad.png",
                    width: 25,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "关闭广告",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
