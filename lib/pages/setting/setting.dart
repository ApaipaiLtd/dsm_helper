import 'dart:ui';

import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/constants/dsm_image_url.dart';
import 'package:dsm_helper/models/Syno/Core/NormalUser.dart';
import 'package:dsm_helper/models/Syno/Core/Terminal.dart';
import 'package:dsm_helper/pages/backup/backup.dart';
import 'package:dsm_helper/pages/server/select_server.dart';
import 'package:dsm_helper/pages/setting/dialogs/feedback_dialog.dart';
import 'package:dsm_helper/pages/setting/dialogs/logout_dialog.dart';
import 'package:dsm_helper/pages/setting/dialogs/shutdown_dialog.dart';
import 'package:dsm_helper/pages/setting/dialogs/ssh_dialog.dart';
import 'package:dsm_helper/pages/setting/vip.dart';
import 'package:dsm_helper/providers/dark_mode.dart';
import 'package:dsm_helper/pages/setting/feedback.dart';
import 'package:dsm_helper/pages/setting/helper_setting.dart';
import 'package:dsm_helper/pages/terminal/select_server.dart';
import 'package:dsm_helper/pages/user/setting.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:dsm_helper/widgets/terminal_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:provider/provider.dart';

class SettingItem extends StatelessWidget {
  final String name;
  final String icon;
  final OnPressed? onPressed;
  const SettingItem({required this.name, required this.icon, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: CupertinoButton(
        onPressed: onPressed,
        // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(16),
        color: AppTheme.of(context)?.cardColor,
        borderRadius: BorderRadius.circular(10),

        child: Row(
          children: [
            Image.asset(
              "assets/icons/$icon.png",
              width: 24,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "$name",
                style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
              ),
            ),
            Icon(
              CupertinoIcons.right_chevron,
              color: AppTheme.of(context)?.placeholderColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeButton extends StatelessWidget {
  const ThemeButton(this.image, this.type, this.text, {super.key});
  final String image;
  final int type;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.of(context).pop();
        Provider.of<DarkModeProvider>(context, listen: false).changeMode(type);
      },
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(25),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(image),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Terminal terminal = Terminal();
  NormalUser normalUser = NormalUser();

  bool terminalLoading = true;
  bool shuttingDown = false;
  bool rebooting = false;
  @override
  void initState() {
    getTerminalInfo();
    getNormalUser();
    super.initState();
  }

  getTerminalInfo() async {
    terminal = await Terminal.get();
    setState(() {
      terminalLoading = false;
    });
  }

  getNormalUser() async {
    normalUser = await NormalUser.get();
    setState(() {});
  }

  power(bool reboot, bool force) async {
    setState(() {
      if (reboot) {
        rebooting = true;
      } else {
        shuttingDown = true;
      }
    });
    // var res = await Api.power(type, force);
    // setState(() {
    //   if (type == "shutdown") {
    //     shuttingDown = false;
    //   } else {
    //     rebooting = false;
    //   }
    // });
    // if (res['success']) {
    //   Utils.toast("已发送指令");
    // } else if (res['error']['code'] == 117) {
    //   List errors = res['error']['errors']['runningTasks'];
    //   List msgs = [];
    //   for (int i = 0; i < errors.length; i++) {
    //     List titles = errors[i].split(":");
    //     if (titles.length == 3) {
    //       msgs.add(Utils.strings[titles[0]][titles[1]][titles[2]]);
    //     }
    //     //系统正在处理下列任务。现在关机可能会导致套件异常或数据丢失。是否确定要继续？
    //     showCupertinoModalPopup(
    //       context: context,
    //       builder: (context) {
    //         return Material(
    //           color: Colors.transparent,
    //           child: Container(
    //             width: double.infinity,
    //             decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
    //             child: SafeArea(
    //               top: false,
    //               child: Padding(
    //                 padding: EdgeInsets.all(20),
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: <Widget>[
    //                     Text(
    //                       "系统正在处理下列任务。现在关机可能会导致套件异常或数据丢失。是否确定要继续？",
    //                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    //                     ),
    //                     SizedBox(
    //                       height: 12,
    //                     ),
    //                     Text(
    //                       "${msgs.join("\n")}",
    //                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    //                     ),
    //                     SizedBox(
    //                       height: 22,
    //                     ),
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                           child: CupertinoButton(
    //                             onPressed: () async {
    //                               Navigator.of(context).pop();
    //                               power(type, true);
    //                             },
    //                             color: Theme.of(context).scaffoldBackgroundColor,
    //                             borderRadius: BorderRadius.circular(25),
    //                             padding: EdgeInsets.symmetric(vertical: 10),
    //                             child: Text(
    //                               "强制${type == "shutdown" ? "关机" : "重启"}",
    //                               style: TextStyle(fontSize: 18, color: Colors.redAccent),
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: 16,
    //                         ),
    //                         Expanded(
    //                           child: CupertinoButton(
    //                             onPressed: () async {
    //                               Navigator.of(context).pop();
    //                             },
    //                             color: Theme.of(context).scaffoldBackgroundColor,
    //                             borderRadius: BorderRadius.circular(25),
    //                             padding: EdgeInsets.symmetric(vertical: 10),
    //                             child: Text(
    //                               "取消",
    //                               style: TextStyle(fontSize: 18),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(
    //                       height: 8,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   }
    // } else {
    //   Utils.toast("操作失败，code:${res['error']['code']}");
    // }
  }

  onShutdown({bool reboot = false}) async {
    bool? res = await ShutdownDialog.show(context: context, reboot: reboot);
    if (res != null) {
      power(reboot, false);
    }
  }

  onTheme() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "主题颜色",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ThemeButton("assets/light.png", 0, "亮色"),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: ThemeButton("assets/dark.png", 1, "暗色"),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: ThemeButton("assets/auto.png", 2, "跟随系统"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(25),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "取消",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    InitDataProvider initDataProvider = context.watch<InitDataProvider>();
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text(
          "设置",
        ),
        actions: [
          CupertinoButton(
            onPressed: () {
              context.push(HelperSetting(), name: "helper_setting");
            },
            child: Image.asset(
              "assets/icons/setting.png",
              width: 24,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                context.push(UserSetting(), name: "user_setting").then((res) {
                  if (res == true) {
                    getNormalUser();
                  }
                });
              },
              child: SizedBox(
                height: 170,
                child: Stack(
                  children: [
                    if (initDataProvider.initData.userSettings?.desktop?.wallpaper != null && (initDataProvider.initData.userSettings!.desktop!.wallpaper!.customizeBackground == true))
                      ExtendedImage.network(
                        "${Api.dsm.baseUrl}/webapi/entry.cgi?api=SYNO.Core.PersonalSettings&method=wallpaper&version=1&path=%22%22&retina=true&_sid=${Api.dsm.sid}",
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      )
                    else
                      ExtendedImage.network(
                        "${Api.dsm.baseUrl}/${(Utils.version == 7 ? DsmImage.v7() : DsmImage.v6()).desktopBackgroundImage}",
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    if (Theme.of(context).brightness == Brightness.dark)
                      Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    color: Colors.white24,
                                    child: Image.asset(
                                      "assets/devices/ds_923+.png",
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${initDataProvider.initData.session?.user}",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, shadows: [BoxShadow(color: Colors.white, spreadRadius: 30, blurRadius: 15)]),
                                    ),
                                    Text(
                                      "${Api.dsm.baseUrl}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 14, shadows: [BoxShadow(color: Colors.white, spreadRadius: 30, blurRadius: 15)]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      LogoutDialog.show(context: context, otpEnable: normalUser.otpEnable == true);
                                    },
                                    child: Image.asset(
                                      "assets/icons/exit.png",
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  CupertinoButton(
                                    onPressed: () {
                                      context.push(SelectServer(), name: "select_server");
                                    },
                                    child: Image.asset(
                                      "assets/icons/change.png",
                                      width: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  if (terminal.enableSsh != null)
                                    CupertinoButton(
                                      onPressed: () async {
                                        bool? enableSsh = await SshDialog.show(context: context, enable: !terminal.enableSsh!);
                                        if (enableSsh != null) {
                                          terminal.enableSsh = enableSsh;
                                          try {
                                            bool? res = await terminal.set();
                                            if (res == true) {
                                              setState(() {});
                                            }
                                          } on DsmException catch (e) {
                                            if (e.code == 105) {
                                              Utils.toast("高版本DSM禁止未加密接口修改SSH配置，请前往网页版手动设置");
                                            }
                                          }
                                        }
                                      },
                                      child: Image.asset(
                                        "assets/icons/ssh.png",
                                        width: 20,
                                        color: terminal.enableSsh! ? AppTheme.of(context)?.successColor : Colors.white,
                                      ),
                                    ),
                                  CupertinoButton(
                                    onPressed: rebooting
                                        ? null
                                        : () {
                                            onShutdown(reboot: true);
                                          },
                                    child: rebooting
                                        ? LoadingWidget(size: 20)
                                        : Image.asset(
                                            "assets/icons/reboot.png",
                                            width: 20,
                                            color: AppTheme.of(context)?.warningColor,
                                          ),
                                  ),
                                  CupertinoButton(
                                    onPressed: shuttingDown ? null : onShutdown,
                                    child: shuttingDown
                                        ? LoadingWidget(size: 20)
                                        : Image.asset(
                                            "assets/icons/shutdown.png",
                                            width: 20,
                                            color: AppTheme.of(context)?.errorColor,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                if (Utils.notReviewAccount && Utils.vipExpireTime.difference(DateTime.now()).inDays < 7 && !Utils.vipForever)
                  SettingItem(
                    name: "会员中心",
                    icon: "vip",
                    onPressed: () async {
                      context.push(Vip(), name: "vip");
                    },
                  ),
                SettingItem(name: "主题", icon: "theme", onPressed: onTheme),
                SettingItem(
                  name: "终端",
                  icon: "terminal",
                  onPressed: () {
                    context.push(SelectTerminalServer(), name: "select_server");
                  },
                ),
                SettingItem(
                  name: "相册备份",
                  icon: "upload_cloud",
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (context) {
                            return Backup();
                          },
                          settings: RouteSettings(name: "backup")),
                    );
                  },
                ),
                SettingItem(
                  name: "问题反馈",
                  icon: "feedback",
                  onPressed: () async {
                    if (Utils.notReviewAccount) {
                      FeedbackDialog.show(context: context);
                    } else {
                      context.push(Feedback(), name: "feedback");
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
