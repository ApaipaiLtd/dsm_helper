import 'dart:async';

import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_response.dart';
import 'package:dsm_helper/models/Syno/Core/CurrentConnection.dart';
import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:dsm_helper/models/Syno/Core/ExternalDevice/Storage/Device.dart';
import 'package:dsm_helper/models/Syno/Core/Notify.dart';
import 'package:dsm_helper/models/Syno/Core/Notify/DsmNotifyStrings.dart';
import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart' hide Size;
import 'package:dsm_helper/pages/control_panel/external_device/dialogs/eject_external_device_dialog.dart';
import 'package:dsm_helper/pages/control_panel/external_device/external_device.dart';
import 'package:dsm_helper/pages/dashboard/bus/eject_external_device_bus.dart';
import 'package:dsm_helper/pages/dashboard/dialogs/external_device_popup.dart';
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
import 'package:dsm_helper/providers/external_device_provider.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/providers/setting_provider.dart';
import 'package:dsm_helper/providers/storage_provider.dart';
import 'package:dsm_helper/providers/system_info_provider.dart';
import 'package:dsm_helper/providers/utilization_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/bus/bus.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/empty_widget.dart';
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
  DsmNotify dsmNotify = DsmNotify();
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
    getInitData();
    bus.on<EjectExternalDeviceEvent>().listen((event) {
      getExternalDeviceTask(loop: false);
    });
    super.initState();
  }

  getInitData() async {
    InitDataModel initData = await InitDataModel.get();
    InitDataProvider initDataProvider = context.read<InitDataProvider>();
    initDataProvider.setInitData(initData);
    Utils.version = int.parse(initData.session!.majorversion!);
    setState(() {});
    getData();
  }

  // getGroups() async {
  //   Utils.groups = await GroupsModel.fetch();
  //   FirstLaunchDialog.show(context);
  // }

  getNotifyStrings() async {
    Utils.notifyStrings = await DsmNotifyStrings.get();
  }

  getExternalDeviceTask({bool loop = true}) async {
    try {
      List<DsmResponse> batchRes = await Api.dsm.batch(apis: [Device(api: "SYNO.Core.ExternalDevice.Storage.USB"), Device(api: "SYNO.Core.ExternalDevice.Storage.eSATA")]);
      ExternalDeviceProvider externalDeviceProvider = context.read<ExternalDeviceProvider>();
      externalDeviceProvider.setExternalDevice(usb: batchRes[0].data, esata: batchRes[1].data);
      if (loop) {
        await Future.delayed(Duration(seconds: 30));
        getExternalDeviceTask();
      }
    } catch (e) {}
  }

  getMediaConverter() async {
    // var res = await Api.mediaConverter("status");
    // if (res['success']) {
    //   setState(() {
    //     converter = res['data'];
    //     if (converter != null && (converter!['photo_remain'] + converter!['thumb_remain'] + converter!['video_remain'] > 0)) {
    //       Future.delayed(Duration(seconds: 5)).then((value) => getMediaConverter());
    //     }
    //   });
    // }
  }

  getUtilizationTask() async {
    UtilizationProvider utilizationProvider = context.read<UtilizationProvider>();
    try {
      Utilization utilization = await Utilization.get();
      utilizationProvider.setUtilization(utilization);
    } catch (e) {}
    await Future.delayed(Duration(seconds: refreshDuration));
    getUtilizationTask();
  }

  getNotifyTask({bool loop = true}) async {
    try {
      dsmNotify = await DsmNotify.notify();
      setState(() {});
    } catch (e) {}

    if (loop) {
      await Future.delayed(Duration(seconds: 30));
      getNotifyTask();
    }
  }

  getSystemInfoTask({bool loop = true}) async {
    try {
      List<DsmResponse> batchRes = await api.Api.dsm.batch(apis: [System()]);
      batchRes.forEach((element) {
        switch (element.data.runtimeType.toString()) {
          case "System":
            SystemInfoProvider provider = context.read<SystemInfoProvider>();
            provider.setSystemInfo(element.data);
            break;
        }
      });
    } catch (e) {}

    if (loop) {
      await Future.delayed(Duration(seconds: 30));
      getNotifyTask();
    }
  }

  getData() async {
    getExternalDeviceTask();
    // getMediaConverter();

    InitDataModel initData = context.read<InitDataProvider>().initData;
    List<String> widgets = initData.userSettings?.synoSDSWidgetInstance?.moduleList ?? [];

    if (widgets.contains("SYNO.SDS.SystemInfoApp.StorageUsageWidget")) {
      try {
        Storage storage = await Storage.loadInfo();
        StorageProvider storageProvider = context.read<StorageProvider>();
        storageProvider.setStorage(storage);
      } catch (e) {}
    }
    getSystemInfoTask();

    getUtilizationTask();

    getNotifyTask();

    setState(() {
      loading = false;
      success = true;
    });
    return;
  }

  Widget _buildWidgetItem(widget) {
    switch (widget) {
      case "SYNO.SDS.SystemInfoApp.SystemHealthWidget":
        return SystemHealthWidget();
      case "SYNO.SDS.SystemInfoApp.ConnectionLogWidget":
        return ConnectionLogWidget();
      case "SYNO.SDS.TaskScheduler.TaskSchedulerWidget":
        return TaskSchedulerWidget();
      case "SYNO.SDS.SystemInfoApp.RecentLogWidget":
        return RecentLogWidget();
      case "SYNO.SDS.ResourceMonitor.Widget":
        return ResourceMonitorWidget();
      case "SYNO.SDS.SystemInfoApp.StorageUsageWidget":
        return StorageUsageWidget();
      case "SYNO.SDS.SystemInfoApp.FileChangeLogWidget":
        return FileChangeLogWidget();
      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = context.watch<SettingProvider>();
    InitDataModel initData = context.watch<InitDataProvider>().initData;
    ExternalDeviceProvider externalDeviceProvider = context.watch<ExternalDeviceProvider>();
    return GlassScaffold(
      key: _scaffoldKey,
      appBar: GlassAppBar(
        leadingWidth: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            if (externalDeviceProvider.devices.length > 0)
              CupertinoButton(
                onPressed: () {
                  ExternalDevicePopup.show(context);
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
                MediaConverterPopup.show(converter!, context: context);
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
                context.push(WidgetSetting(), name: "widget_setting");
              },
              child: Image.asset(
                "assets/icons/setting.png",
                width: 24,
                height: 24,
              ),
            ),
          CupertinoButton(
            onPressed: () {
              context.push(Notify(dsmNotify), name: "notify").then((res) {
                if (res != null && res == true) {
                  setState(() {
                    dsmNotify.items = [];
                  });
                  getNotifyTask(loop: false);
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
                    if (settingProvider.showShortcut) ShortcutList(),
                    if (initData.userSettings?.synoSDSWidgetInstance?.moduleList != null && initData.userSettings!.synoSDSWidgetInstance!.moduleList!.isNotEmpty)
                      ...initData.userSettings!.synoSDSWidgetInstance!.moduleList!.map((widget) {
                        return _buildWidgetItem(widget);
                        // return Text(widget);
                      }).toList()
                    else
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          EmptyWidget(
                            text: "未添加小组件",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: CupertinoButton(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              color: AppTheme.of(context)?.primaryColor,
                              borderRadius: BorderRadius.circular(15),
                              onPressed: () {
                                context.push(WidgetSetting(), name: "widget_setting");
                              },
                              child: Text(
                                '添加小组件',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
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
                          color: AppTheme.of(context)?.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          onPressed: () {
                            getData();
                          },
                          child: Text(
                            '刷新',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
