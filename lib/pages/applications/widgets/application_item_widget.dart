import 'package:dsm_helper/pages/applications/application_enums.dart';
import 'package:dsm_helper/pages/common/browser.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:flutter/material.dart';

class ApplicationItemWidget extends StatelessWidget {
  final String packageName;
  const ApplicationItemWidget(this.packageName, {super.key});

  @override
  Widget build(BuildContext context) {
    ApplicationEnum applicationEnum = ApplicationEnum.formPackageName(packageName);
    return GestureDetector(
      onTap: () {
        if (applicationEnum == ApplicationEnum.xunlei) {
          context.push(Browser(
            title: "迅雷-远程设备",
            url: "https://pan.xunlei.com/yc",
          ));
        } else {
          context.pushNamed("/${applicationEnum.icon}");
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    "assets/applications/${applicationEnum.iconFolder == null ? '7/' : ''}${applicationEnum.icon}.png",
                    height: 45,
                    width: 45,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    applicationEnum.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            // if (appNotify != null && appNotify!['SYNO.SDS.AdminCenter.Application'] != null)
            //   Positioned(
            //     right: 30,
            //     child: Badge(
            //       appNotify!['SYNO.SDS.AdminCenter.Application']['unread'],
            //       size: 20,
            //     ),
            //   ),
          ],
        ),
      ),
    );
    // switch (packageName) {
    //   case "SYNO.SDS.AdminCenter.Application":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //               builder: (context) {
    //                 return ControlPanel();
    //               },
    //               settings: RouteSettings(name: "control_panel")));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           child: Stack(
    //             children: [
    //               Align(
    //                 alignment: Alignment.center,
    //                 child: Column(
    //                   children: [
    //                     Image.asset(
    //                       "assets/applications/${Utils.version}/control_panel.png",
    //                       height: 45,
    //                       width: 45,
    //                       fit: BoxFit.contain,
    //                     ),
    //                     SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text("控制面板"),
    //                   ],
    //                 ),
    //               ),
    //               // if (appNotify != null && appNotify!['SYNO.SDS.AdminCenter.Application'] != null)
    //               //   Positioned(
    //               //     right: 30,
    //               //     child: Badge(
    //               //       appNotify!['SYNO.SDS.AdminCenter.Application']['unread'],
    //               //       size: 20,
    //               //     ),
    //               //   ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.PkgManApp.Instance":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //               builder: (context) {
    //                 return Packages();
    //               },
    //               settings: RouteSettings(name: "packages")));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Stack(
    //             children: [
    //               Align(
    //                 alignment: Alignment.center,
    //                 child: Column(
    //                   children: [
    //                     Image.asset(
    //                       "assets/applications/${Utils.version}/package_center.png",
    //                       height: 45,
    //                       width: 45,
    //                       fit: BoxFit.contain,
    //                     ),
    //                     SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text("套件中心"),
    //                   ],
    //                 ),
    //               ),
    //               if (appNotify != null && appNotify!['SYNO.SDS.PkgManApp.Instance'] != null)
    //                 Positioned(
    //                   right: 30,
    //                   child: Badge(
    //                     appNotify!['SYNO.SDS.PkgManApp.Instance']['unread'],
    //                     size: 20,
    //                   ),
    //                 ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.ResourceMonitor.Instance":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //               builder: (context) {
    //                 return ResourceMonitor();
    //               },
    //               settings: RouteSettings(name: "resource_monitor")));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/${Utils.version}/resource_monitor.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text("资源监控"),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.StorageManager.Instance":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //               builder: (context) {
    //                 return StorageManager();
    //               },
    //               settings: RouteSettings(name: "storage_manager")));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/${Utils.version}/storage_manager.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text("存储空间管理员"),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.LogCenter.Instance":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //               builder: (context) {
    //                 return LogCenter();
    //               },
    //               settings: RouteSettings(name: "log_center")));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/${Utils.version}/log_center.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text("日志中心"),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.SecurityScan.Instance":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(
    //             CupertinoPageRoute(
    //                 builder: (context) {
    //                   return SecurityScan();
    //                 },
    //                 settings: RouteSettings(name: "security_scan")),
    //           );
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Stack(
    //             children: [
    //               Align(
    //                 alignment: Alignment.center,
    //                 child: Column(
    //                   children: [
    //                     Image.asset(
    //                       "assets/applications/${Utils.version}/security_scan.png",
    //                       height: 45,
    //                       width: 45,
    //                       fit: BoxFit.contain,
    //                     ),
    //                     SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text("安全顾问"),
    //                   ],
    //                 ),
    //               ),
    //               if (appNotify != null && appNotify!['SYNO.SDS.SecurityScan.Instance'] != null)
    //                 Positioned(
    //                   right: 30,
    //                   child: Badge(
    //                     appNotify!['SYNO.SDS.SecurityScan.Instance']['unread'],
    //                     size: 20,
    //                   ),
    //                 ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.XLPan.Application":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).push(
    //             CupertinoPageRoute(builder: (context) {
    //               return Browser(
    //                 title: "迅雷-远程设备",
    //                 url: "https://pan.xunlei.com/yc",
    //               );
    //             }),
    //           );
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/xunlei.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text("迅雷"),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.Virtualization.Application":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //             builder: (context) {
    //               return VirtualMachine();
    //             },
    //             settings: RouteSettings(name: "virtual_machine_manager"),
    //           ));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/${Utils.version}/virtual_machine.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 "Virtual Machine Manager",
    //                 maxLines: 1,
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.Docker.Application":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //             builder: (context) {
    //               return Docker();
    //             },
    //             settings: RouteSettings(name: "docker"),
    //           ));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/docker.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 "Docker",
    //                 maxLines: 1,
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.ContainerManager.Application":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //             builder: (context) {
    //               return Docker(title: "Container Manager");
    //             },
    //             settings: RouteSettings(name: "Container Manager"),
    //           ));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/container_manager.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 "Container Manager",
    //                 maxLines: 1,
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.SDS.DownloadStation.Application":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //             builder: (context) {
    //               return DownloadStation();
    //             },
    //             settings: RouteSettings(name: "download_station"),
    //           ));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/download_station.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 "Download Station",
    //                 maxLines: 1,
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.Photo.AppInstance":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //             builder: (context) {
    //               return Moments();
    //             },
    //             settings: RouteSettings(name: "moments"),
    //           ));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/6/moments.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 "Moments",
    //                 maxLines: 1,
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    //   case "SYNO.Foto.AppInstance":
    //     apps.add(
    //       GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           Navigator.of(context).push(CupertinoPageRoute(
    //             builder: (context) {
    //               return Photos();
    //             },
    //             settings: RouteSettings(name: "photos"),
    //           ));
    //         },
    //         child: Container(
    //           width: (MediaQuery.of(context).size.width * 0.8 - 60) / 2,
    //           decoration: BoxDecoration(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           padding: EdgeInsets.symmetric(vertical: 20),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 "assets/applications/7/synology_photos.png",
    //                 height: 45,
    //                 width: 45,
    //                 fit: BoxFit.contain,
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Text(
    //                 "Synology Photos",
    //                 maxLines: 1,
    //                 textAlign: TextAlign.center,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //     break;
    // }
    // return const Placeholder();
  }
}
