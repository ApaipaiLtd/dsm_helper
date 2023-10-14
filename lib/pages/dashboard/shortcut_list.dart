import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:dsm_helper/pages/common/browser.dart';
import 'package:dsm_helper/pages/control_panel/control_panel.dart';
import 'package:dsm_helper/pages/docker/detail.dart';
import 'package:dsm_helper/pages/docker/docker.dart';
import 'package:dsm_helper/pages/download_station/download_station.dart';
import 'package:dsm_helper/pages/log_center/log_center.dart';
import 'package:dsm_helper/pages/moments/moments.dart';
import 'package:dsm_helper/pages/packages/packages.dart';
import 'package:dsm_helper/pages/resource_monitor/resource_monitor.dart';
import 'package:dsm_helper/pages/storage_manager/storage_manager.dart';
import 'package:dsm_helper/pages/virtual_machine/virtual_machine.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/init_data_provider.dart';
import '../photos/photos.dart';

class ShortcutList extends StatelessWidget {
  // final List<ShortcutItems> shortcutItems;
  // final BuildContext context;
  // final Map system;
  // final List volumes;
  // final List disks;
  // final Map appNotify;
  // final List? validAppViewOrder;
  const ShortcutList(
      // this.shortcutItems,
      // this.system,
      // this.volumes,
      // this.disks,
      // this.appNotify,
      // this.context,
      {
    // this.validAppViewOrder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> supportedShortcuts = [
      "SYNO.SDS.PkgManApp.Instance",
      "SYNO.SDS.AdminCenter.Application",
      "SYNO.SDS.StorageManager.Instance",
      "SYNO.SDS.Docker.Application",
      "SYNO.SDS.Docker.ContainerDetail.Instance",
      "SYNO.SDS.LogCenter.Instance",
      "SYNO.SDS.ResourceMonitor.Instance",
      "SYNO.SDS.Virtualization.Application",
      "SYNO.SDS.DownloadStation.Application",
      "SYNO.SDS.XLPan.Application",
    ];
    InitDataModel initData = context.watch<InitDataProvider>().initData;
    List<ShortcutItems> shortcutItems = initData.userSettings?.desktop?.shortcutItems != null ? initData.userSettings!.desktop!.shortcutItems! : [];
    List<String> validAppViewOrder = initData.userSettings?.desktop?.validAppviewOrder != null ? initData.userSettings!.desktop!.validAppviewOrder! : [];
    if (shortcutItems.where((element) => supportedShortcuts.contains(element.className)).length > 0 && Utils.notReviewAccount) {
      return Container(
        height: 82,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return _buildShortcutItem(
              context,
              shortcutItems[i],
              validAppViewOrder,
            );
          },
          itemCount: shortcutItems.length,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildShortcutItem(BuildContext context, ShortcutItems shortcut, List<String> validAppViewOrder) {
    String icon = "";
    String name = "";
    int unread = 0;
    Widget? page;
    String routerName = "";
    switch (shortcut.className) {
      case "SYNO.SDS.PkgManApp.Instance":
        icon = "assets/applications/${Utils.version}/package_center.png";
        name = "套件中心";
        page = Packages();
        routerName = "packages";
        // if (appNotify != null && appNotify['SYNO.SDS.PkgManApp.Instance'] != null) {
        //   unread = appNotify['SYNO.SDS.PkgManApp.Instance']['unread'];
        // }
        break;
      case "SYNO.SDS.AdminCenter.Application":
        icon = "assets/applications/${Utils.version}/control_panel.png";
        name = "控制面板";
        page = ControlPanel();
        routerName = "control_panel";
        // if (appNotify != null && appNotify['SYNO.SDS.AdminCenter.Application'] != null) {
        //   unread = appNotify['SYNO.SDS.AdminCenter.Application']['unread'];
        // }
        break;
      case "SYNO.SDS.StorageManager.Instance":
        icon = "assets/applications/${Utils.version}/storage_manager.png";
        name = "存储空间管理员";
        page = StorageManager();
        routerName = "storage_manager";
        break;
      case "SYNO.SDS.Docker.Application":
        if (validAppViewOrder.contains("SYNO.SDS.ContainerManager.Application")) {
          icon = "assets/applications/container_manager.png";
          name = "Container Manager";
          page = Docker(
            title: "Container Manager",
          );
        } else {
          icon = "assets/applications/docker.png";
          name = "Docker";
          page = Docker();
        }

        routerName = "docker";
        break;
      case "SYNO.SDS.Docker.ContainerDetail.Instance":
        if (validAppViewOrder.contains("SYNO.SDS.ContainerManager.Application")) {
          icon = "assets/applications/container_manager.png";
        } else {
          icon = "assets/applications/docker.png";
        }
        name = "${shortcut.param?.data?.name}";
        if (shortcut.type == 'url') {
          page = Browser(
            url: shortcut.url!,
            title: name,
          );
          routerName = "browser";
        } else {
          page = ContainerDetail(name);
          routerName = "docker_container_detail";
        }

        break;
      case "SYNO.SDS.LogCenter.Instance":
        icon = "assets/applications/${Utils.version}/log_center.png";
        name = "日志中心";
        page = LogCenter();
        routerName = "log_center";
        break;
      case "SYNO.SDS.ResourceMonitor.Instance":
        icon = "assets/applications/${Utils.version}/resource_monitor.png";
        name = "资源监控";
        page = ResourceMonitor();
        routerName = "resource_monitor";

        break;
      // case "SYNO.SDS.SecurityScan.Instance":
      //   icon = "assets/applications/security_scan.png";
      //   break;
      case "SYNO.SDS.Virtualization.Application":
        icon = "assets/applications/${Utils.version}/virtual_machine.png";
        name = "Virtual Machine Manager";
        page = VirtualMachine();
        routerName = "virtual_machine_manager";
        break;
      case "SYNO.Photo.AppInstance":
        icon = "assets/applications/6/moments.png";
        name = "Moments";
        page = Moments();
        routerName = "moments";
        break;
      case "SYNO.Foto.AppInstance":
        icon = "assets/applications/7/synology_photos.png";
        name = "Synology Photos";
        page = Photos();
        routerName = "photos";
        break;
      case "SYNO.SDS.DownloadStation.Application":
        icon = "assets/applications/download_station.png";
        name = "Download Station";
        page = DownloadStation();
        routerName = "download_station";
        break;
      case "SYNO.SDS.XLPan.Application":
        icon = "assets/applications/xunlei.png";
        name = "迅雷";
        page = Browser(
          title: "迅雷-远程设备",
          url: "https://pan.xunlei.com/yc/?fromApp=paipai",
        );
        routerName = "xunlei";
        break;
    }
    if (icon != "") {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) {
                return page!;
              },
              settings: RouteSettings(name: routerName),
            ),
          );
        },
        child: Container(
          width: 100,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset(
                      icon,
                      width: 45,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 32,
                      child: Center(
                        child: Text(
                          "$name",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (unread > 0)
                Positioned(
                  right: 20,
                  top: 10,
                  child: Container(
                    alignment: Alignment.center,
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(1, 1)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
