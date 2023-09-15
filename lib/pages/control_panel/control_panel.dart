import 'package:dsm_helper/pages/control_panel/external_device/external_device.dart';
import 'package:dsm_helper/pages/control_panel/file_service/file_service.dart';
import 'package:dsm_helper/pages/control_panel/media_index/media_index.dart';
import 'package:dsm_helper/pages/control_panel/network/network.dart';
import 'package:dsm_helper/pages/control_panel/power/power.dart';
import 'package:dsm_helper/pages/control_panel/public_access/public_access.dart';
import 'package:dsm_helper/pages/control_panel/ssh/ssh.dart';
import 'package:dsm_helper/pages/control_panel/task_scheduler/task_scheduler.dart';
import 'package:dsm_helper/pages/control_panel/update_reset/update_reset.dart';
import 'package:dsm_helper/pages/control_panel/user_groups/user_group.dart';
import 'package:dsm_helper/pages/control_panel/users/users.dart';
import 'package:dsm_helper/utils/badge.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'shared_folders/shared_folders.dart';
import 'package:dsm_helper/pages/control_panel/info/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Badge;

class ControlPanel extends StatefulWidget {
  final Map? system;
  final List volumes;
  final List disks;
  final Map notify;
  ControlPanel(this.system, this.volumes, this.disks, this.notify);
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "控制面板",
        ),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Text(
                    "文件共享",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (content) {
                                return SharedFolders();
                              },
                              settings: RouteSettings(name: "share_folders")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/${Utils.version}/shared_folders.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "共享文件夹",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return FileService();
                              },
                              settings: RouteSettings(name: "file_service")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/${Utils.version}/file_services.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "文件服务",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return Users();
                              },
                              settings: RouteSettings(name: "users")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/${Utils.version}/users.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                Utils.version < 7 ? "用户账户" : "用户与群组",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (Utils.version < 7)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) {
                                  return UserGroups();
                                },
                                settings: RouteSettings(name: "user_groups")));
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 120) / 3,
                            height: (MediaQuery.of(context).size.width - 120) / 3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/control_panel/${Utils.version}/groups.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "用户群组",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      // Container(
                      //   width: (MediaQuery.of(context).size.width - 120) / 3,
                      //   height: (MediaQuery.of(context).size.width - 120) / 3,
                      //
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).scaffoldBackgroundColor,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         "assets/control_panel/${Utils.version}/ldap.png",
                      //         height: 30,
                      //         width: 30,
                      //         fit: BoxFit.contain,
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Text(
                      //         "域/LDAP",
                      //         style: TextStyle(fontSize: 12),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Text(
                    "连接性",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      // if (Utils.version < 7)
                      //   Container(
                      //     width: (MediaQuery.of(context).size.width - 120) / 3,
                      //     height: (MediaQuery.of(context).size.width - 120) / 3,
                      //     curveType: CurveType.convex,
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image.asset(
                      //           "assets/control_panel/${Utils.version}/quickconnect.png",
                      //           height: 30,
                      //           width: 30,
                      //           fit: BoxFit.contain,
                      //         ),
                      //         SizedBox(
                      //           height: 5,
                      //         ),
                      //         Text(
                      //           "Quick Connect",
                      //           style: TextStyle(fontSize: 12),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return PublicAccess();
                              },
                              settings: RouteSettings(name: "public_access")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/${Utils.version}/public_access.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "外部访问",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return Network();
                              },
                              settings: RouteSettings(name: "network")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/${Utils.version}/network.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "网络",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // if (Utils.version < 7)
                      //   Container(
                      //     width: (MediaQuery.of(context).size.width - 120) / 3,
                      //     height: (MediaQuery.of(context).size.width - 120) / 3,
                      //     curveType: CurveType.convex,
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image.asset(
                      //           "assets/control_panel/${Utils.version}/dhcp_server.png",
                      //           height: 30,
                      //           width: 30,
                      //           fit: BoxFit.contain,
                      //         ),
                      //         SizedBox(
                      //           height: 5,
                      //         ),
                      //         Text(
                      //           "DHCP Server",
                      //           style: TextStyle(fontSize: 12),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // if (Utils.version < 7)
                      //   Container(
                      //     width: (MediaQuery.of(context).size.width - 120) / 3,
                      //     height: (MediaQuery.of(context).size.width - 120) / 3,
                      //     curveType: CurveType.convex,
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image.asset(
                      //           "assets/control_panel/6/wireless.png",
                      //           height: 30,
                      //           width: 30,
                      //           fit: BoxFit.contain,
                      //         ),
                      //         SizedBox(
                      //           height: 5,
                      //         ),
                      //         Text(
                      //           "无线",
                      //           style: TextStyle(fontSize: 12),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // Container(
                      //   width: (MediaQuery.of(context).size.width - 120) / 3,
                      //   height: (MediaQuery.of(context).size.width - 120) / 3,
                      //   curveType: CurveType.convex,
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).scaffoldBackgroundColor,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         "assets/control_panel/${Utils.version}/security.png",
                      //         height: 30,
                      //         width: 30,
                      //         fit: BoxFit.contain,
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Text(
                      //         "安全性",
                      //         style: TextStyle(fontSize: 12),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      if (Utils.version >= 7)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (content) {
                                  return SshSetting();
                                },
                                settings: RouteSettings(name: "ssh_setting")));
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 120) / 3,
                            height: (MediaQuery.of(context).size.width - 120) / 3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/control_panel/${Utils.version}/terminal_and_SNMP.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "终端机和SNMP",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Text(
                    "系统",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (content) {
                                return SystemInfo(0, widget.system, widget.volumes, widget.disks);
                              },
                              settings: RouteSettings(name: "system_info_all")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/${Utils.version}/info_center.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "信息中心",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   width: (MediaQuery.of(context).size.width - 120) / 3,
                      //   height: (MediaQuery.of(context).size.width - 120) / 3,
                      //
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).scaffoldBackgroundColor,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         "assets/control_panel/${Utils.version}/login_style.png",
                      //         height: 30,
                      //         width: 30,
                      //         fit: BoxFit.contain,
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Text(
                      //         Utils.version < 7 ? "主题样式" : "登录门户",
                      //         style: TextStyle(fontSize: 12),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   width: (MediaQuery.of(context).size.width - 120) / 3,
                      //   height: (MediaQuery.of(context).size.width - 120) / 3,
                      //
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).scaffoldBackgroundColor,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         "assets/control_panel/${Utils.version}/region.png",
                      //         height: 30,
                      //         width: 30,
                      //         fit: BoxFit.contain,
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Text(
                      //         "区域选项",
                      //         style: TextStyle(fontSize: 12),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   width: (MediaQuery.of(context).size.width - 120) / 3,
                      //   height: (MediaQuery.of(context).size.width - 120) / 3,
                      //
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).scaffoldBackgroundColor,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         "assets/control_panel/${Utils.version}/notifications.png",
                      //         height: 30,
                      //         width: 30,
                      //         fit: BoxFit.contain,
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Text(
                      //         "通知设置",
                      //         style: TextStyle(fontSize: 12),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      if (Utils.version < 7)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) {
                                  return TaskScheduler();
                                },
                                settings: RouteSettings(name: "task_scheduler")));
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 120) / 3,
                            height: (MediaQuery.of(context).size.width - 120) / 3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/control_panel/${Utils.version}/task_scheduler.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "任务计划",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return Power();
                              },
                              settings: RouteSettings(name: "power")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/${Utils.version}/hardware_and_power.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "硬件和电源",
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return ExternalDevice();
                              },
                              settings: RouteSettings(name: "external_device")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/${Utils.version}/external_devices.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "外接设备",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                            return UpdateReset();
                          }));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/control_panel/${Utils.version}/update_and_reset.png",
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "更新和还原",
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              if (widget.notify != null && widget.notify['SYNO.SDS.AdminCenter.Update_Reset.Main'] != null && widget.notify['SYNO.SDS.AdminCenter.Update_Reset.Main']['unread'] != null)
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: Badge(
                                    widget.notify['SYNO.SDS.AdminCenter.Update_Reset.Main']['unread'],
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  child: Text(
                    "应用程序",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      // if (Utils.version >= 7)
                      //   Container(
                      //     width: (MediaQuery.of(context).size.width - 120) / 3,
                      //     height: (MediaQuery.of(context).size.width - 120) / 3,
                      //
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image.asset(
                      //           "assets/control_panel/${Utils.version}/synology_account.png",
                      //           height: 30,
                      //           width: 30,
                      //           fit: BoxFit.contain,
                      //         ),
                      //         SizedBox(
                      //           height: 5,
                      //         ),
                      //         Text(
                      //           "Synology 账户",
                      //           maxLines: 1,
                      //           overflow: TextOverflow.clip,
                      //           style: TextStyle(fontSize: 12),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // Container(
                      //   width: (MediaQuery.of(context).size.width - 120) / 3,
                      //   height: (MediaQuery.of(context).size.width - 120) / 3,
                      //
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).scaffoldBackgroundColor,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         "assets/control_panel/${Utils.version}/privilege.png",
                      //         height: 30,
                      //         width: 30,
                      //         fit: BoxFit.contain,
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Text(
                      //         Utils.version < 7 ? "权限" : "应用程序权限",
                      //         style: TextStyle(fontSize: 12),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // if (Utils.version < 7)
                      //   Container(
                      //     width: (MediaQuery.of(context).size.width - 120) / 3,
                      //     height: (MediaQuery.of(context).size.width - 120) / 3,
                      //
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image.asset(
                      //           "assets/control_panel/${Utils.version}/portal.png",
                      //           height: 30,
                      //           width: 30,
                      //           fit: BoxFit.contain,
                      //         ),
                      //         SizedBox(
                      //           height: 5,
                      //         ),
                      //         Text(
                      //           "应用程序门户",
                      //           maxLines: 1,
                      //           overflow: TextOverflow.clip,
                      //           style: TextStyle(fontSize: 12),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return MediaIndex();
                              },
                              settings: RouteSettings(name: "media_index")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/${Utils.version}/file_index.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "索引服务",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // if (Utils.version < 7)
                      //   Container(
                      //     width: (MediaQuery.of(context).size.width - 120) / 3,
                      //     height: (MediaQuery.of(context).size.width - 120) / 3,
                      //
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).scaffoldBackgroundColor,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image.asset(
                      //           "assets/control_panel/${Utils.version}/share_folder_sync.png",
                      //           height: 30,
                      //           width: 30,
                      //           fit: BoxFit.contain,
                      //         ),
                      //         SizedBox(
                      //           height: 5,
                      //         ),
                      //         Text(
                      //           "共享文件夹同步",
                      //           maxLines: 1,
                      //           overflow: TextOverflow.clip,
                      //           style: TextStyle(fontSize: 12),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      if (Utils.version < 7)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (content) {
                                  return SshSetting();
                                },
                                settings: RouteSettings(name: "ssh_setting")));
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 120) / 3,
                            height: (MediaQuery.of(context).size.width - 120) / 3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/control_panel/${Utils.version}/terminal_and_SNMP.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "终端机和SNMP",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (Utils.version >= 7)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) {
                                  return TaskScheduler();
                                },
                                settings: RouteSettings(name: "task_scheduler")));
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 120) / 3,
                            height: (MediaQuery.of(context).size.width - 120) / 3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/control_panel/${Utils.version}/task_scheduler.png",
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "任务计划",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
