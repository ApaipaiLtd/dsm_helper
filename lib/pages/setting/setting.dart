import 'dart:convert';
import 'dart:ui';

import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/pages/backup/backup.dart';
import 'package:dsm_helper/pages/control_panel/ssh/ssh.dart';
import 'package:dsm_helper/pages/login/accounts.dart';
import 'package:dsm_helper/pages/login/confirm_logout.dart';
import 'package:dsm_helper/pages/server/select_server.dart';
import 'package:dsm_helper/pages/setting/vip.dart';
import 'package:dsm_helper/providers/dark_mode.dart';
import 'package:dsm_helper/pages/setting/feedback.dart';
import 'package:dsm_helper/pages/setting/helper_setting.dart';
import 'package:dsm_helper/pages/terminal/select_server.dart';
import 'package:dsm_helper/pages/user/setting.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/terminal_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:fluwx/fluwx.dart';

import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

class SettingButton extends StatelessWidget {
  final bool loading;
  final String name;
  final String icon;
  final OnPressed? onPressed;
  const SettingButton({required this.name, required this.icon, this.onPressed, this.loading = false, super.key});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 81) / 3;
    return SizedBox(
      width: width,
      child: CupertinoButton(
        onPressed: onPressed,
        // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 20),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        child: Column(
          children: [
            loading
                ? CupertinoActivityIndicator(radius: 20)
                : Image.asset(
                    "assets/icons/$icon.png",
                    width: 40,
                  ),
            SizedBox(
              height: 5,
            ),
            Text(
              "$name",
              style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
            )
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
  bool checking = false;
  bool? ssh;
  bool? telnet;

  bool sshLoading = true;
  bool shuttingDown = false;
  bool rebooting = false;
  String? sshPort;

  List servers = [];

  String account = "";
  String host = "";
  bool otpEnable = false;
  bool otpEnforced = false;

  String email = "";
  @override
  void initState() {
    getData();
    getServers();
    getNormalUser();
    account = SpUtil.getString("account")!;
    host = SpUtil.getString("host")!;
    super.initState();
  }

  getServers() async {
    String serverString = SpUtil.getString("servers")!;
    if (serverString.isNotBlank) {
      servers = json.decode(serverString);
    }
  }

  getData() async {
    // var res = await Api.terminalInfo();
    // if (res['success']) {
    //   setState(() {
    //     ssh = res['data']['enable_ssh'];
    //     telnet = res['data']['enable_telnet'];
    //     sshPort = res['data']['ssh_port'].toString();
    //     sshLoading = false;
    //   });
    // } else {
    //   setState(() {
    //     sshLoading = false;
    //     ssh = null;
    //   });
    // }
  }

  getNormalUser() async {
    // var res = await Api.normalUser("get");
    // if (res['success']) {
    //   setState(() {
    //     otpEnable = res['data']['OTP_enable'];
    //     otpEnforced = res['data']['OTP_enforced'];
    //     email = res['data']['email'];
    //   });
    // }
  }

  power(String type, bool force) async {
    setState(() {
      if (type == "shutdown") {
        shuttingDown = true;
      } else {
        rebooting = true;
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

  onShutdown() async {
    if (shuttingDown) {
      return;
    }
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
                      "确认关机",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "确认要关闭设备吗？",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              power("shutdown", false);
                            },
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(25),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "确认关机",
                              style: TextStyle(fontSize: 18, color: Colors.redAccent),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            color: Theme.of(context).disabledColor,
                            borderRadius: BorderRadius.circular(25),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "取消",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
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

  onReboot() async {
    if (rebooting) {
      return;
    }
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
                      "确认重启",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "确认要重新启动设备？",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              power("reboot", false);
                            },
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(25),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "确认重启",
                              style: TextStyle(fontSize: 18, color: Colors.redAccent),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: CupertinoButton(
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
                        ),
                      ],
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
    double width = (context.width - 81) / 3;
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
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
                    if (initDataProvider.initData.userSettings?.desktop?.wallpaper != null && (initDataProvider.initData.userSettings!.desktop!.wallpaper!.customizeBackground! || initDataProvider.initData.userSettings!.desktop!.wallpaper!.customizeBackground!))
                      ExtendedImage.network(
                        "${Api.dsm.baseUrl}/webapi/entry.cgi?api=SYNO.Core.PersonalSettings&method=wallpaper&version=1&path=%22%22&retina=true&_sid=${Api.dsm.sid}",
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
                                    SizedBox(
                                      height: 5,
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
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) {
                                          return ConfirmLogout(otpEnable);
                                        },
                                      );
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
                                  if (ssh != null)
                                    CupertinoButton(
                                      onPressed: () {
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
                                                          "提示",
                                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                                        ),
                                                        SizedBox(
                                                          height: 12,
                                                        ),
                                                        Text(
                                                          "确认${ssh! ? '关闭' : '开启'}SSH吗？",
                                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                                                        ),
                                                        SizedBox(
                                                          height: 22,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: CupertinoButton(
                                                                onPressed: () async {
                                                                  Navigator.of(context).pop();
                                                                  setState(() {
                                                                    sshLoading = true;
                                                                  });
                                                                  // var res = await Api.setTerminal(!ssh!, telnet, sshPort);
                                                                  // print(res);
                                                                  // if (!res['success']) {
                                                                  //   Utils.toast("操作失败，代码：${res['error']['code']}");
                                                                  // }
                                                                  await getData();
                                                                },
                                                                color: Theme.of(context).scaffoldBackgroundColor,
                                                                borderRadius: BorderRadius.circular(25),
                                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                                child: Text(
                                                                  "确认${ssh! ? '关闭' : '开启'}SSH",
                                                                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Expanded(
                                                              child: CupertinoButton(
                                                                onPressed: () async {
                                                                  context.pop();
                                                                  context.push(SshSetting(), name: "ssh_setting");
                                                                },
                                                                color: Theme.of(context).disabledColor,
                                                                borderRadius: BorderRadius.circular(25),
                                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                                child: Text(
                                                                  "取消",
                                                                  style: TextStyle(fontSize: 18),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
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
                                      },
                                      child: Image.asset(
                                        "assets/icons/ssh.png",
                                        width: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  CupertinoButton(
                                    onPressed: onReboot,
                                    child: Image.asset(
                                      "assets/icons/reboot.png",
                                      width: 20,
                                      color: AppTheme.of(context)?.warningColor,
                                    ),
                                  ),
                                  CupertinoButton(
                                    onPressed: shuttingDown ? null : onShutdown,
                                    child: Image.asset(
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
              height: 30,
            ),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                SettingButton(name: "主题", icon: "theme", onPressed: onTheme),
                SettingButton(
                  name: "终端",
                  icon: "terminal",
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (context) {
                            return SelectTerminalServer();
                          },
                          settings: RouteSettings(name: "select_server")),
                    );
                  },
                ),
                SettingButton(
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
                SettingButton(
                  name: "问题反馈",
                  icon: "edit",
                  onPressed: () async {
                    if (Utils.notReviewAccount) {
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
                                        "您将进入“阿派派软件”微信小程序进行问题反馈。是否确定要继续？",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 22,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CupertinoButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                Fluwx().open(target: MiniProgram(username: "gh_6c07712ef0fb"));
                                              },
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.circular(25),
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              child: Text(
                                                "进入小程序",
                                                style: TextStyle(fontSize: 18, color: Colors.redAccent),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: CupertinoButton(
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
                                          ),
                                        ],
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
                    } else {
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                        return Feedback();
                      }));
                    }
                  },
                ),
                if (Utils.notReviewAccount && Utils.vipExpireTime.difference(DateTime.now()).inDays < 7 && !Utils.vipForever)
                  SettingButton(
                    name: "关闭广告",
                    icon: "no_ad",
                    onPressed: () async {
                      Navigator.of(context)
                          .push(
                        CupertinoPageRoute(
                          builder: (context) {
                            return Vip();
                          },
                          settings: RouteSettings(name: "vip"),
                        ),
                      )
                          .then((value) {
                        setState(() {});
                      });
                    },
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
