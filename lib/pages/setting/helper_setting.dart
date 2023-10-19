import 'dart:io';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/pages/common/gesture_password.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/setting/about.dart';
import 'package:dsm_helper/pages/setting/dialogs/launch_auth_popup.dart';
import 'package:dsm_helper/pages/setting/logout.dart';
import 'package:dsm_helper/providers/setting_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/utils/neu_picker.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';

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
    BiometricType.iris: "虹膜",
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
    SettingProvider settingProvider = context.watch<SettingProvider>();
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("助手设置"),
      ),
      body: ListView(
        children: [
          WidgetCard(
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Utils.vibrateOn = !Utils.vibrateOn;
                      SpUtil.putBool("vibrate_on", Utils.vibrateOn);
                      if (Utils.vibrateOn) {
                        Utils.vibrate(FeedbackType.light);
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/vibrate.png",
                              width: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "震动",
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 16,
                            ),
                          ],
                        ),
                        if (Utils.vibrateOn)
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
                                        Utils.vibrateNormal = !Utils.vibrateNormal;
                                        SpUtil.putBool("vibrate_warning", Utils.vibrateNormal);
                                        if (Utils.vibrateNormal) {
                                          Utils.vibrate(FeedbackType.light);
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
                                          if (Utils.vibrateNormal)
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
                                        Utils.vibrateWarning = !Utils.vibrateWarning;
                                        SpUtil.putBool("vibrate_warning", Utils.vibrateWarning);
                                        if (Utils.vibrateWarning) {
                                          Utils.vibrate(FeedbackType.warning);
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
                                          if (Utils.vibrateWarning)
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/player.png",
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "始终使用第三方播放器",
                        style: TextStyle(fontSize: 16, height: 1.6),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 20,
                        child: Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: videoPlayer,
                            onChanged: (v) {
                              setState(() {
                                videoPlayer = v;
                              });
                              SpUtil.putBool("video_player", videoPlayer);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return NeuPicker(
                          List.generate(20, (index) => "${index + 1}s"),
                          value: List.generate(20, (index) => index + 1).indexOf(settingProvider.refreshDuration),
                          onConfirm: (v) {
                            settingProvider.setRefreshDuration(v + 1);
                          },
                        );
                      },
                    );
                  },
                  child: Padding(
                    // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),

                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/player.png",
                          width: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "资源监控更新频率",
                          style: TextStyle(fontSize: 16, height: 1.6),
                        ),
                        Spacer(),
                        Text(
                          "${settingProvider.refreshDuration}s",
                          style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                        ),
                        Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/home.png",
                        width: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "启动时选择服务器/账号",
                        style: TextStyle(fontSize: 16, height: 1.6),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 20,
                        child: Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: launchAccountPage,
                            onChanged: (v) {
                              setState(() {
                                launchAccountPage = v;
                              });
                              SpUtil.putBool("launch_account_page", launchAccountPage);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    LaunchAuthPopup.show(context);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/safe.png",
                              width: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "安全启动",
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Image.asset(
                              "assets/icons/gesture.png",
                              width: 20,
                              color: AppTheme.of(context)?.placeholderColor,
                            ),
                            Image.asset(
                              "assets/icons/fingerprint.png",
                              width: 20,
                              color: AppTheme.of(context)?.placeholderColor,
                            ),
                            Image.asset(
                              "assets/icons/faceid.png",
                              width: 20,
                              color: AppTheme.of(context)?.placeholderColor,
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 16,
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
                                        // Utils.setStorage("launch_password", password ? "1" : "0");
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
                                            Utils.vibrate(FeedbackType.warning);
                                            Utils.toast("请先开启图形密码后再开启指纹");
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
                                              Utils.toast("生物验证不可用");
                                            } else if (e.code == auth_error.passcodeNotSet) {
                                              Utils.toast("系统未设置密码");
                                            } else if (e.code == auth_error.lockedOut) {
                                              Utils.toast("认证失败次数过多，请稍后再试");
                                            } else {
                                              Utils.toast(e.message ?? "认证失败");
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
                                        //   Utils.setStorage("launch_biometrics", biometrics ? "1" : "0");
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
                if (!Utils.notReviewAccount)
                  GestureDetector(
                    onTap: () {
                      context.push(Logout(), name: "logout");
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/logout.png",
                            width: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "注销账号",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          WidgetCard(
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    var hide = showWeuiLoadingToast(context: context);
                    clearDiskCachedImages();
                    hide();
                    Utils.toast("图片缓存清理完成");
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/clear_cache.png",
                          width: 30,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "清理图片缓存",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push(About(), name: "about");
                  },
                  // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/about.png",
                          width: 30,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "关于${Utils.appName}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(
                          CupertinoIcons.right_chevron,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
