import 'dart:async';

import 'package:dsm_helper/apis/dsm_api/dsm_response.dart';
import 'package:dsm_helper/models/Syno/Core/CurrentConnection.dart';
import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:dsm_helper/models/Syno/Core/Notify.dart';
import 'package:dsm_helper/models/Syno/Core/Notify/DsmNotifyStrings.dart';
import 'package:dsm_helper/models/Syno/Core/SyslogClient/Log.dart';
import 'package:dsm_helper/models/Syno/Core/SyslogClient/Status.dart';
import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:dsm_helper/models/Syno/Core/TaskScheduler.dart';
import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart' hide Size;
import 'package:dsm_helper/models/base_model.dart';
import 'package:dsm_helper/models/setting/group_model.dart';
import 'package:dsm_helper/pages/control_panel/external_device/external_device.dart';
import 'package:dsm_helper/pages/dashboard/dialogs/first_launch_dialog.dart';
import 'package:dsm_helper/pages/dashboard/media_converter.dart';
import 'package:dsm_helper/pages/dashboard/shortcut_list.dart';
import 'package:dsm_helper/pages/dashboard/widget_setting.dart';
import 'package:dsm_helper/pages/dashboard/widgets/connection_log_widget.dart';
import 'package:dsm_helper/pages/dashboard/widgets/file_change_log_widget.dart';
import 'package:dsm_helper/pages/dashboard/widgets/recent_log_widget.dart';
import 'package:dsm_helper/pages/dashboard/widgets/resource_monitor_widget.dart';
import 'package:dsm_helper/pages/dashboard/widgets/storage_usage_widget.dart';
import 'package:dsm_helper/pages/dashboard/widgets/system_health_widget.dart';
import 'package:dsm_helper/pages/dashboard/widgets/task_scheduler_widget.dart';
import 'package:dsm_helper/pages/notify/notify.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/providers/setting.dart';
import 'package:dsm_helper/providers/storage_provider.dart';
import 'package:dsm_helper/providers/system_info_provider.dart';
import 'package:dsm_helper/providers/utilization_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dsm_helper/apis/api.dart' as api;

class Dashboard extends StatefulWidget {
  Dashboard({key}) : super(key: key);
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CurrentConnection connectedUsers = CurrentConnection();
  TaskScheduler taskScheduler = TaskScheduler();
  SynoClientStatus latestLog = SynoClientStatus();
  DsmNotify dsmNotify = DsmNotify();
  SyslogClientLog fileChangeLogs = SyslogClientLog();
  List esatas = [];
  List usbs = [];
  Map? appNotify;
  Map? converter;
  bool loading = true;
  bool success = true;
  int refreshDuration = 10;
  // int get maxNetworkSpeed {
  //   int maxSpeed = 0;
  //   for (int i = 0; i < networks.length; i++) {
  //     int maxVal = max(networks[i]['rx'], networks[i]['tx']);
  //     if (maxSpeed < maxVal) {
  //       maxSpeed = maxVal;
  //     }
  //   }
  //   return maxSpeed;
  // }

  String msg = "";
  @override
  void initState() {
    getNotifyStrings();
    initData();
    getData(init: true);
    super.initState();
  }

  initData() async {
    InitDataModel initData = await InitDataModel.get();
    InitDataProvider initDataProvider = context.read<InitDataProvider>();
    initDataProvider.setInitData(initData);
    Utils.version = int.parse(initData.session!.majorversion!);
    setState(() {});
  }

  getGroups() async {
    Utils.groups = await GroupsModel.fetch();
    FirstLaunchDialog.show(context);
  }

  getNotifyStrings() async {
    Utils.notifyStrings = await DsmNotifyStrings.get();
  }

  getExternalDevice() async {
    var res = await Api.externalDevice();
    if (res['success']) {
      List result = res['data']['result'];
      result.forEach((item) {
        if (item['success'] == true) {
          switch (item['api']) {
            case "SYNO.Core.ExternalDevice.Storage.eSATA":
              setState(() {
                esatas = item['data']['devices'];
              });
              break;
            case "SYNO.Core.ExternalDevice.Storage.USB":
              setState(() {
                usbs = item['data']['devices'];
              });
              break;
          }
        }
      });
    }
  }

  getMediaConverter() async {
    var res = await Api.mediaConverter("status");
    if (res['success']) {
      setState(() {
        converter = res['data'];
        if (converter != null && (converter!['photo_remain'] + converter!['thumb_remain'] + converter!['video_remain'] > 0)) {
          Future.delayed(Duration(seconds: 5)).then((value) => getMediaConverter());
        }
      });
    }
  }

  initUtilizationTask() async {
    UtilizationProvider utilizationProvider = context.read<UtilizationProvider>();
    Utilization utilization = await Utilization.get();
    utilizationProvider.setUtilization(utilization);
    setState(() {});
    await Future.delayed(Duration(seconds: 10));

    initUtilizationTask();
  }

  initNotifyTask({bool loop = true}) async {
    dsmNotify = await DsmNotify.notify();
    setState(() {});

    if (loop) {
      await Future.delayed(Duration(seconds: 30));
      initNotifyTask();
    }
  }

  getData({bool init = false}) async {
    // getExternalDevice();
    // getMediaConverter();
    List<BaseModel> apis = [System(), SyslogClientLog()];
    List<DsmResponse> batchRes = await api.Api.dsm.batch(apis: apis);
    batchRes.forEach((element) {
      switch (element.data.runtimeType.toString()) {
        case "System":
          SystemInfoProvider provider = context.read<SystemInfoProvider>();
          provider.setSystemInfo(element.data);
          break;
        case "SyslogClientLog":
          setState(() {
            fileChangeLogs = element.data;
          });
      }
    });
    taskScheduler = await TaskScheduler.list();

    connectedUsers = await CurrentConnection.get();

    latestLog = await SynoClientStatus.get();

    Storage storage = await Storage.loadInfo();
    StorageProvider storageProvider = context.read<StorageProvider>();
    storageProvider.setStorage(storage);

    initUtilizationTask();

    initNotifyTask();

    setState(() {
      loading = false;
      success = true;
    });
    return;
    // var res = await Api.systemInfo(widgets);
    //
    // if (res['success']) {
    //   if (!mounted) {
    //     return;
    //   }
    //
    //   setState(() {
    //     loading = false;
    //     success = true;
    //   });
    //
    //   List result = res['data']['result'];
    //   result.forEach((item) {
    //     if (item['success'] == true) {
    //       switch (item['api']) {
    //         case "SYNO.Core.System.Utilization":
    //           setState(() {
    //             utilization = item['data'];
    //             if (networks.length > 20) {
    //               networks.removeAt(0);
    //             }
    //             networks.add(item['data']['network'][0]);
    //           });
    //           break;
    //         case "SYNO.Core.System":
    //           setState(() {
    //             system = item['data'];
    //             Utils.systemVersion(system!['firmware_ver']);
    //           });
    //           break;
    //         case "SYNO.Core.CurrentConnection":
    //           setState(() {
    //             connectedUsers = item['data']['items'];
    //           });
    //           break;
    //         case "SYNO.Storage.CGI.Storage":
    //           setState(() {
    //             ssdCaches = item['data']['ssdCaches'];
    //             volumes = item['data']['volumes'];
    //             volumes.sort((a, b) {
    //               return a['num_id'].compareTo(b['num_id']);
    //             });
    //             disks = item['data']['disks'];
    //           });
    //           break;
    //         case 'SYNO.Core.TaskScheduler':
    //           setState(() {
    //             tasks = item['data']['tasks'];
    //           });
    //           break;
    //         case 'SYNO.Core.SyslogClient.Status':
    //           setState(() {
    //             latestLog = item['data']['logs'];
    //           });
    //           break;
    //         case "SYNO.Core.DSMNotify":
    //           setState(() {
    //             notifies = item['data']['items'];
    //           });
    //           break;
    //         case "SYNO.Core.AppNotify":
    //           setState(() {
    //             appNotify = item['data'];
    //           });
    //           break;
    //         case "SYNO.Core.SyslogClient.Log":
    //           Log.logger.info(jsonEncode(item['data']));
    //           setState(() {
    //             fileLogs = item['data']['items'];
    //           });
    //           break;
    //       }
    //     }
    //
    //     // else if(item['api'] == ""){
    //     //
    //     // }
    //   });
    // } else {
    //   setState(() {
    //     if (loading) {
    //       success = res['success'];
    //       loading = false;
    //     }
    //
    //     msg = res['msg'] ?? "加载失败，code:${res['error']['code']}";
    //   });
    // }
    // if (init && mounted) {
    //   Future.delayed(Duration(seconds: refreshDuration)).then((value) {
    //     getData(init: init);
    //   });
    //   return;
    // }
  }

  Widget _buildWidgetItem(widget) {
    if (widget == "SYNO.SDS.SystemInfoApp.SystemHealthWidget") {
      return SystemHealthWidget();
    } else if (widget == "SYNO.SDS.SystemInfoApp.ConnectionLogWidget") {
      return ConnectionLogWidget(connectedUsers);
    } else if (widget == "SYNO.SDS.TaskScheduler.TaskSchedulerWidget") {
      return TaskSchedulerWidget(taskScheduler);
    } else if (widget == "SYNO.SDS.SystemInfoApp.RecentLogWidget") {
      return RecentLogWidget(latestLog);
    } else if (widget == "SYNO.SDS.ResourceMonitor.Widget") {
      return ResourceMonitorWidget();
    } else if (widget == "SYNO.SDS.SystemInfoApp.StorageUsageWidget") {
      return StorageUsageWidget();
    } else if (widget == "SYNO.SDS.SystemInfoApp.FileChangeLogWidget") {
      return FileChangeLogWidget(fileChangeLogs);
    } else {
      return Container();
    }
  }

  Widget _buildESataItem(esata) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "${esata['dev_title']}",
                ),
                SizedBox(
                  width: 10,
                ),
                esata['status'] == "normal"
                    ? Label(
                        "正常",
                        Colors.green,
                        fill: true,
                      )
                    : Label(
                        esata['status'],
                        Colors.red,
                        fill: true,
                      ),
                SizedBox(
                  width: 10,
                ),
                Spacer(),
                CupertinoButton(
                  onPressed: () async {
                    var res = await Api.ejectEsata(esata['dev_id']);
                    if (res['success']) {
                      Utils.toast("设备已退出");
                      getData();
                    } else {
                      Utils.toast("设备退出失败，代码${res['error']['code']}");
                    }
                  },
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  padding: EdgeInsets.all(5),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      "assets/icons/eject.png",
                      width: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    refreshDuration = context.watch<SettingProvider>().refreshDuration;

    InitDataModel initData = context.watch<InitDataProvider>().initData;
    return GlassScaffold(
      key: _scaffoldKey,
      appBar: GlassAppBar(
        leadingWidth: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            // if ((esatas + usbs).length > 0)
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
                                  "外接设备",
                                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                ...(esatas + usbs).map(_buildESataItem).toList(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CupertinoButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(CupertinoPageRoute(
                                              builder: (context) {
                                                return ExternalDevice();
                                              },
                                              settings: RouteSettings(name: "external_device")));
                                        },
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(25),
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "查看详情",
                                          style: TextStyle(fontSize: 18),
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
              },
              child: Image.asset(
                "assets/icons/external_devices.png",
                width: 24,
                height: 24,
              ),
            ),
            // if (converter != null && (converter!['photo_remain'] + converter!['thumb_remain'] + converter!['video_remain'] > 0))
            CupertinoButton(
              onPressed: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return MediaConverter(converter!);
                    });
              },
              child: Image.asset(
                "assets/icons/converting.png",
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
        actions: [
          if (Utils.notReviewAccount)
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                  return WidgetSetting();
                })).then((res) {
                  if (res != null) {
                    getData();
                  }
                });
              },
              child: Image.asset(
                "assets/icons/plus_circle.png",
                width: 24,
                height: 24,
              ),
            ),
          CupertinoButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                CupertinoPageRoute(
                  builder: (context) {
                    return Notify(dsmNotify);
                  },
                  settings: RouteSettings(name: "notify"),
                ),
              )
                  .then((res) {
                if (res != null && res) {
                  setState(() {
                    dsmNotify.items = [];
                  });
                }
              });
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(
                  "assets/icons/message.png",
                  width: 24,
                  height: 24,
                  color: dsmNotify.items == null ? AppTheme.of(context)?.placeholderColor : null,
                ),
                if (dsmNotify.items != null && dsmNotify.items!.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: 8,
                    height: 8,
                  )
              ],
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: loading
          ? Center(
              child: LoadingWidget(size: 30),
            )
          : success
              ? ListView(
                  // padding: EdgeInsets.only(top: context.padding.top + 60, bottom: 10),
                  children: [
                    ShortcutList(),
                    if (initData.userSettings?.synoSDSWidgetInstance?.moduleList != null && initData.userSettings!.synoSDSWidgetInstance!.moduleList!.length > 0)
                      ...initData.userSettings!.synoSDSWidgetInstance!.moduleList!.map((widget) {
                        return _buildWidgetItem(widget);
                        // return Text(widget);
                      }).toList()
                    else
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "未添加小组件",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 200,
                              child: CupertinoButton(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(20),
                                onPressed: () {
                                  Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                                    return WidgetSetting();
                                  })).then((res) {
                                    if (res != null) {
                                      getData();
                                    }
                                  });
                                },
                                child: Text(
                                  ' 添加 ',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("$msg"),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          onPressed: () {
                            getData();
                          },
                          child: Text(
                            ' 刷新 ',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.refresh),
      //   onPressed: () {
      //     getData();
      //   },
      // ),
    );
  }
}
