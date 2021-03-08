import 'package:dsm_helper/pages/control_panel/external_device/external_device.dart';
import 'package:dsm_helper/pages/control_panel/media_index/media_index.dart';
import 'package:dsm_helper/pages/control_panel/ssh/ssh.dart';
import 'package:dsm_helper/pages/control_panel/task_scheduler/task_scheduler.dart';
import 'package:dsm_helper/pages/control_panel/user_groups/user_group.dart';
import 'package:dsm_helper/pages/control_panel/users/users.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';

import 'shared_folders/shared_folders.dart';
import 'package:dsm_helper/pages/control_panel/info/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class ControlPanel extends StatefulWidget {
  final Map system;
  final List volumes;
  final List disks;
  ControlPanel(this.system, this.volumes, this.disks);
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text(
          "控制面板",
        ),
      ),
      body: ListView(
        children: [
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            bevel: 10,
            curveType: CurveType.flat,
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
                        child: NeuCard(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          curveType: CurveType.flat,
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          bevel: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/shared_folders.png",
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/file_services.png",
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return Users();
                              },
                              settings: RouteSettings(name: "users")));
                        },
                        child: NeuCard(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          curveType: CurveType.flat,
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          bevel: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/users.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "用户账户",
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
                                return UserGroups();
                              },
                              settings: RouteSettings(name: "user_groups")));
                        },
                        child: NeuCard(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          curveType: CurveType.flat,
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          bevel: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/groups.png",
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/directory_service.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "域/LDAP",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
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
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            bevel: 10,
            curveType: CurveType.flat,
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/quickconnect.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Quick Connect",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/public_access.png",
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/network.png",
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/dhcp_server.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "DHCP Server",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/wireless.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "无线",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/security.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "安全性",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
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
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            bevel: 10,
            curveType: CurveType.flat,
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
                        child: NeuCard(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          curveType: CurveType.flat,
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          bevel: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/info_center.png",
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/login_style.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "主题样式",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/region.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "区域选项",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/notifications.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "通知设置",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return TaskScheduler();
                              },
                              settings: RouteSettings(name: "task_scheduler")));
                        },
                        child: NeuCard(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          curveType: CurveType.flat,
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          bevel: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/task_scheduler.png",
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/hardware_and_power.png",
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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return ExternalDevice();
                              },
                              settings: RouteSettings(name: "external_device")));
                        },
                        child: NeuCard(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          curveType: CurveType.flat,
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          bevel: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/external_devices.png",
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/update_and_reset.png",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            bevel: 10,
            curveType: CurveType.flat,
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/privilege.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "权限",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/portal.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "应用程序门户",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          return;
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) {
                                return MediaIndex();
                              },
                              settings: RouteSettings(name: "media_index")));
                        },
                        child: NeuCard(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          curveType: CurveType.flat,
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          bevel: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/file_index.png",
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
                      NeuCard(
                        width: (MediaQuery.of(context).size.width - 120) / 3,
                        height: (MediaQuery.of(context).size.width - 120) / 3,
                        curveType: CurveType.flat,
                        decoration: NeumorphicDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        bevel: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/control_panel/share_folder_sync.png",
                              height: 30,
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "共享文件夹同步",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (content) {
                                return SshSetting();
                              },
                              settings: RouteSettings(name: "ssh_setting")));
                        },
                        child: NeuCard(
                          width: (MediaQuery.of(context).size.width - 120) / 3,
                          height: (MediaQuery.of(context).size.width - 120) / 3,
                          curveType: CurveType.flat,
                          decoration: NeumorphicDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          bevel: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/control_panel/terminal_and_SNMP.png",
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
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
