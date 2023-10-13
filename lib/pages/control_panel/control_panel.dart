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
import 'package:dsm_helper/pages/control_panel/widgets/control_panel_item_widget.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'shared_folders/shared_folders.dart';
import 'package:dsm_helper/pages/control_panel/info/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Badge;

class ControlPanel extends StatefulWidget {
  final Map? system;
  final List volumes;
  final List disks;
  final Map notify;
  ControlPanel({this.system, this.volumes = const [], this.disks = const [], this.notify = const {}});
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    int count = (context.width - 64) ~/ 80;
    double width = (context.width - 64) / count;
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("控制面板"),
      ),
      body: ListView(
        children: [
          WidgetCard(
            title: "文件共享",
            body: Wrap(
              children: [
                ControlPanelItemWidget(
                  title: "共享文件夹",
                  icon: "shared_folders",
                  width: width,
                  onTap: () {
                    context.push(SharedFolders(), name: 'share_folders');
                  },
                ),
                ControlPanelItemWidget(
                  title: "文件服务",
                  icon: "file_services",
                  width: width,
                  onTap: () {
                    context.push(FileService(), name: 'file_service');
                  },
                ),
                ControlPanelItemWidget(
                  title: Utils.version < 7 ? "用户账户" : "用户与群组",
                  icon: "users",
                  width: width,
                  onTap: () {
                    context.push(Users(), name: 'users');
                  },
                ),
                if (Utils.version < 7)
                  ControlPanelItemWidget(
                    onTap: () {
                      context.push(UserGroups(), name: 'user_groups');
                    },
                    title: "用户群组",
                    icon: 'groups',
                    width: width,
                  ),
                // ControlPanelItemWidget(
                //   onTap: () {
                //     // context.push(UserGroups(), name: 'ldap');
                //   },
                //   title: "域/LDAP",
                //   icon: "ldap",
                //   width: width,
                // ),
              ],
            ),
          ),
          WidgetCard(
            title: "连接性",
            body: Wrap(
              children: [
                // ControlPanelItemWidget(
                //   onTap: () {
                //     // context.push(UserGroups(), name: 'ldap');
                //   },
                //   title: "Quick Connect",
                //   icon: "quickconnect",
                //   width: width,
                // ),
                ControlPanelItemWidget(
                  onTap: () {
                    context.push(PublicAccess(), name: 'public_access');
                  },
                  title: "外部访问",
                  icon: "public_access",
                  width: width,
                ),
                ControlPanelItemWidget(
                  onTap: () {
                    context.push(Network(), name: 'network');
                  },
                  title: "网络",
                  icon: "network",
                  width: width,
                ),
                // if (Utils.version < 7)
                //   ControlPanelItemWidget(
                //     onTap: () {
                //       // context.push(Network(), name: 'dhcp_server');
                //     },
                //     title: "DHCP Server",
                //     icon: "dhcp_server",
                //     width: width,
                //   ),
                // if (Utils.version < 7)
                //   ControlPanelItemWidget(
                //     onTap: () {
                //       // context.push(Network(), name: 'wireless');
                //     },
                //     title: "无线",
                //     icon: "wireless",
                //     width: width,
                //   ),
                // ControlPanelItemWidget(
                //   onTap: () {
                //     // context.push(Network(), name: 'security');
                //   },
                //   title: "安全性",
                //   icon: "security",
                //   width: width,
                // ),
                if (Utils.version >= 7)
                  ControlPanelItemWidget(
                    onTap: () {
                      context.push(SshSetting(), name: 'ssh_setting');
                    },
                    title: "终端机和SNMP",
                    icon: "terminal_and_SNMP",
                    width: width,
                  ),
              ],
            ),
          ),
          WidgetCard(
            title: "系统",
            body: Wrap(
              children: [
                ControlPanelItemWidget(
                  onTap: () {
                    context.push(SystemInfo(0), name: 'system_info_all');
                  },
                  title: "信息中心",
                  icon: "info_center",
                  width: width,
                ),
                // ControlPanelItemWidget(
                //   onTap: () {
                //     // context.push(SystemInfo(0), name: 'login_style');
                //   },
                //   title: Utils.version < 7 ? "主题样式" : "登录门户",
                //   icon: "login_style",
                //   width: width,
                // ),
                // ControlPanelItemWidget(
                //   onTap: () {
                //     // context.push(SystemInfo(0), name: 'region');
                //   },
                //   title: "区域选项",
                //   icon: "region",
                //   width: width,
                // ),
                // ControlPanelItemWidget(
                //   onTap: () {
                //     // context.push(SystemInfo(0), name: 'notifications');
                //   },
                //   title: "通知设置",
                //   icon: "notifications",
                //   width: width,
                // ),
                if (Utils.version < 7)
                  ControlPanelItemWidget(
                    onTap: () {
                      context.push(TaskSchedulerManage(), name: 'task_scheduler');
                    },
                    title: "任务计划",
                    icon: "task_scheduler",
                    width: width,
                  ),
                ControlPanelItemWidget(
                  onTap: () {
                    context.push(Power(), name: 'power');
                  },
                  title: "硬件和电源",
                  icon: "hardware_and_power",
                  width: width,
                ),
                ControlPanelItemWidget(
                  onTap: () {
                    context.push(ExternalDevice(), name: 'external_device');
                  },
                  title: "外接设备",
                  icon: "external_devices",
                  width: width,
                ),
                ControlPanelItemWidget(
                  onTap: () {
                    context.push(UpdateReset(), name: 'update_reset');
                  },
                  title: "更新和还原",
                  icon: "update_and_reset",
                  width: width,
                ),
                // if (widget.notify != null && widget.notify['SYNO.SDS.AdminCenter.Update_Reset.Main'] != null && widget.notify['SYNO.SDS.AdminCenter.Update_Reset.Main']['unread'] != null)
                //   Positioned(
                //     top: 6,
                //     right: 6,
                //     child: Badge(
                //       widget.notify['SYNO.SDS.AdminCenter.Update_Reset.Main']['unread'],
                //       size: 20,
                //     ),
                //   ),
              ],
            ),
          ),
          WidgetCard(
            title: "应用程序",
            body: Wrap(
              children: [
                // if (Utils.version >= 7)
                //   ControlPanelItemWidget(
                //     onTap: () {
                //       // context.push(UpdateReset(), name: 'synology_account');
                //     },
                //     title: "Synology 账户",
                //     icon: "synology_account",
                //     width: width,
                //   ),
                // ControlPanelItemWidget(
                //   onTap: () {
                //     // context.push(UpdateReset(), name: 'privilege');
                //   },
                //   title: Utils.version < 7 ? "权限" : "应用程序权限",
                //   icon: "privilege",
                //   width: width,
                // ),
                // if (Utils.version < 7)
                //   ControlPanelItemWidget(
                //     onTap: () {
                //       // context.push(UpdateReset(), name: 'portal');
                //     },
                //     title: "应用程序门户",
                //     icon: "portal",
                //     width: width,
                //   ),
                ControlPanelItemWidget(
                  onTap: () {
                    context.push(MediaIndex(), name: 'media_index');
                  },
                  title: "索引服务",
                  icon: "file_index",
                  width: width,
                ),
                if (Utils.version < 7)
                  ControlPanelItemWidget(
                    onTap: () {
                      // context.push(UpdateReset(), name: 'share_folder_sync');
                    },
                    title: "共享文件夹同步",
                    icon: "share_folder_sync",
                    width: width,
                  ),
                if (Utils.version < 7)
                  ControlPanelItemWidget(
                    onTap: () {
                      context.push(SshSetting(), name: 'ssh_setting');
                    },
                    title: "终端机和SNMP",
                    icon: "terminal_and_SNMP",
                    width: width,
                  ),
                if (Utils.version >= 7)
                  ControlPanelItemWidget(
                    onTap: () {
                      context.push(TaskSchedulerManage(), name: 'task_scheduler');
                    },
                    title: "任务计划",
                    icon: "task_scheduler",
                    width: width,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
