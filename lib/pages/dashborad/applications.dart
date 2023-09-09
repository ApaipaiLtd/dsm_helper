import 'package:dsm_helper/pages/common/browser.dart';
import 'package:dsm_helper/pages/control_panel/control_panel.dart';
import 'package:dsm_helper/pages/docker/docker.dart';
import 'package:dsm_helper/pages/download_station/download_station.dart';
import 'package:dsm_helper/pages/log_center/log_center.dart';
import 'package:dsm_helper/pages/moments/moments.dart';
import 'package:dsm_helper/pages/packages/packages.dart';
import 'package:dsm_helper/pages/photos/photos.dart';
import 'package:dsm_helper/pages/resource_monitor/resource_monitor.dart';
import 'package:dsm_helper/pages/security_scan/security_scan.dart';
import 'package:dsm_helper/pages/storage_manager/storage_manager.dart';
import 'package:dsm_helper/pages/virtual_machine/virtual_machine.dart';
import 'package:dsm_helper/util/badge.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:neumorphic/neumorphic.dart';

class ApplicationList extends StatelessWidget {
  final List applications;
  final Map system;
  final List volumes;
  final List disks;
  final Map appNotify;
  const ApplicationList(this.applications, this.system, this.volumes, this.disks, this.appNotify, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: _buildApplicationList(context),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildApplicationList(BuildContext context) {
    List<Widget> apps = [];
    applications.forEach((application) {
      switch (application) {
        case "SYNO.SDS.AdminCenter.Application":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return ControlPanel(system, volumes, disks, appNotify['SYNO.SDS.AdminCenter.Application'] == null ? null : appNotify['SYNO.SDS.AdminCenter.Application']['fn']);
                    },
                    settings: RouteSettings(name: "control_panel")));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                padding: EdgeInsets.symmetric(vertical: 20),
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/applications/${Util.version}/control_panel.png",
                            height: 45,
                            width: 45,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("控制面板"),
                        ],
                      ),
                    ),
                    if (appNotify != null && appNotify['SYNO.SDS.AdminCenter.Application'] != null)
                      Positioned(
                        right: 30,
                        child: Badge(
                          appNotify['SYNO.SDS.AdminCenter.Application']['unread'],
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.PkgManApp.Instance":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return Packages(system['firmware_ver']);
                    },
                    settings: RouteSettings(name: "packages")));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/applications/${Util.version}/package_center.png",
                            height: 45,
                            width: 45,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("套件中心"),
                        ],
                      ),
                    ),
                    if (appNotify != null && appNotify['SYNO.SDS.PkgManApp.Instance'] != null)
                      Positioned(
                        right: 30,
                        child: Badge(
                          appNotify['SYNO.SDS.PkgManApp.Instance']['unread'],
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.ResourceMonitor.Instance":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return ResourceMonitor();
                    },
                    settings: RouteSettings(name: "resource_monitor")));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/${Util.version}/resource_monitor.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("资源监控"),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.StorageManager.Instance":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return StorageManager();
                    },
                    settings: RouteSettings(name: "storage_manager")));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/${Util.version}/storage_manager.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("存储空间管理员"),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.LogCenter.Instance":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return LogCenter();
                    },
                    settings: RouteSettings(name: "log_center")));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/${Util.version}/log_center.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("日志中心"),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.SecurityScan.Instance":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  CupertinoPageRoute(
                      builder: (context) {
                        return SecurityScan();
                      },
                      settings: RouteSettings(name: "security_scan")),
                );
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/applications/${Util.version}/security_scan.png",
                            height: 45,
                            width: 45,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("安全顾问"),
                        ],
                      ),
                    ),
                    if (appNotify != null && appNotify['SYNO.SDS.SecurityScan.Instance'] != null)
                      Positioned(
                        right: 30,
                        child: Badge(
                          appNotify['SYNO.SDS.SecurityScan.Instance']['unread'],
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.XLPan.Application":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) {
                    return Browser(
                      title: "迅雷-远程设备",
                      url: "https://pan.xunlei.com/yc",
                    );
                  }),
                );
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/xunlei.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("迅雷"),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.Virtualization.Application":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return VirtualMachine();
                  },
                  settings: RouteSettings(name: "virtual_machine_manager"),
                ));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/${Util.version}/virtual_machine.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Virtual Machine Manager",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.Docker.Application":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return Docker();
                  },
                  settings: RouteSettings(name: "docker"),
                ));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/docker.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Docker",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.ContainerManager.Application":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return Docker(title: "Container Manager");
                  },
                  settings: RouteSettings(name: "Container Manager"),
                ));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/container_manager.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Container Manager",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.SDS.DownloadStation.Application":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return DownloadStation();
                  },
                  settings: RouteSettings(name: "download_station"),
                ));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/download_station.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Download Station",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.Photo.AppInstance":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return Moments();
                  },
                  settings: RouteSettings(name: "moments"),
                ));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/6/moments.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Moments",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
          break;
        case "SYNO.Foto.AppInstance":
          apps.add(
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return Photos();
                  },
                  settings: RouteSettings(name: "photos"),
                ));
              },
              child: NeuCard(
                width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
                curveType: CurveType.flat,
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/applications/7/synology_photos.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Synology Photos",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
          break;
      }
    });
    // if (applications.contains("SYNO.SDS.EzInternet.Instance")) {
    //   apps.add(
    //     NeuCard(
    //       width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //       height: 110,
    //       padding: EdgeInsets.symmetric(vertical: 20),
    //       curveType: CurveType.flat,
    //       decoration: NeumorphicDecoration(
    //         color: Theme.of(context).scaffoldBackgroundColor,
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //       bevel: 20,
    //       child: Column(
    //         children: [
    //           Image.asset(
    //             "assets/applications/ez_internet.png",
    //             height: 45,
    //             width: 45,
    //             fit: BoxFit.contain,
    //           ),
    //           SizedBox(
    //             height: 5,
    //           ),
    //           Text("EZ-Internet"),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    // if (applications.contains("SYNO.SDS.SupportForm.Application")) {
    //   apps.add(
    //     NeuCard(
    //       width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //       curveType: CurveType.flat,
    //       decoration: NeumorphicDecoration(
    //         color: Theme.of(context).scaffoldBackgroundColor,
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //       bevel: 20,
    //       padding: EdgeInsets.symmetric(vertical: 20),
    //       child: Column(
    //         children: [
    //           Image.asset(
    //             "assets/applications/support_center.png",
    //             height: 45,
    //             width: 45,
    //             fit: BoxFit.contain,
    //           ),
    //           SizedBox(
    //             height: 5,
    //           ),
    //           Text("技术支持中心"),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    // if (applications.contains("SYNO.SDS.iSCSI.Application")) {
    //   apps.add(
    //     GestureDetector(
    //       onTap: () {
    //         Navigator.of(context).pop();
    //         Navigator.of(context).push(CupertinoPageRoute(
    //             builder: (context) {
    //               return ISCSIManger();
    //             },
    //             settings: RouteSettings(name: "iSCSI_manager")));
    //       },
    //       child: NeuCard(
    //         width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //         curveType: CurveType.flat,
    //         decoration: NeumorphicDecoration(
    //           color: Theme.of(context).scaffoldBackgroundColor,
    //           borderRadius: BorderRadius.circular(20),
    //         ),
    //         bevel: 20,
    //         padding: EdgeInsets.symmetric(vertical: 20),
    //         child: Column(
    //           children: [
    //             Image.asset(
    //               "assets/applications/iSCSI_manager.png",
    //               height: 45,
    //               width: 45,
    //               fit: BoxFit.contain,
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Text("iSCSI Manager"),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // }

    // if (applications.contains("SYNO.SDS.App.FileStation3.Instance")) {
    //   apps.add(
    //     NeuCard(
    //       width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //       curveType: CurveType.flat,
    //       decoration: NeumorphicDecoration(
    //         color: Theme.of(context).scaffoldBackgroundColor,
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //       bevel: 20,
    //       padding: EdgeInsets.symmetric(vertical: 20),
    //       child: Column(
    //         children: [
    //           Image.asset(
    //             "assets/applications/file_browser.png",
    //             height: 45,
    //             width: 45,
    //             fit: BoxFit.contain,
    //           ),
    //           SizedBox(
    //             height: 5,
    //           ),
    //           Text("File Station"),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    // if (applications.contains("SYNO.Finder.Application")) {
    //   apps.add(
    //     GestureDetector(
    //       onTap: () {
    //         Navigator.of(context).pop();
    //         Navigator.of(context).push(CupertinoPageRoute(
    //             builder: (context) {
    //               return UniversalSearch();
    //             },
    //             settings: RouteSettings(name: "universal_search")));
    //       },
    //       child: NeuCard(
    //         width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //         curveType: CurveType.flat,
    //         decoration: NeumorphicDecoration(
    //           color: Theme.of(context).scaffoldBackgroundColor,
    //           borderRadius: BorderRadius.circular(20),
    //         ),
    //         bevel: 20,
    //         padding: EdgeInsets.symmetric(vertical: 20),
    //         child: Column(
    //           children: [
    //             Image.asset(
    //               "assets/applications/${Util.version}/universal_search.png",
    //               height: 45,
    //               width: 45,
    //               fit: BoxFit.contain,
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Text("Universal Search"),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // }
    // print(applications);

    //SYNO.SDS.PhotoStation  6.0 photo station
    //SYNO.Foto.AppInstance  7.0 photo
    // print(applications);
    return apps;
  }
}
