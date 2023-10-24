import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/providers/setting_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class WidgetSetting extends StatefulWidget {
  WidgetSetting();
  @override
  _WidgetSettingState createState() => _WidgetSettingState();
}

class _WidgetSettingState extends State<WidgetSetting> {
  bool saving = false;
  List<String> allWidgets = [
    "SYNO.SDS.SystemInfoApp.SystemHealthWidget",
    "SYNO.SDS.ResourceMonitor.Widget",
    "SYNO.SDS.SystemInfoApp.StorageUsageWidget",
    "SYNO.SDS.SystemInfoApp.ConnectionLogWidget",
    "SYNO.SDS.TaskScheduler.TaskSchedulerWidget",
    "SYNO.SDS.SystemInfoApp.FileChangeLogWidget",
    "SYNO.SDS.SystemInfoApp.RecentLogWidget",
  ];
  Map name = {
    "SYNO.SDS.SystemInfoApp.FileChangeLogWidget": "文件更改日志",
    "SYNO.SDS.SystemInfoApp.RecentLogWidget": "最新日志",
    "SYNO.SDS.TaskScheduler.TaskSchedulerWidget": "计划任务",
    "SYNO.SDS.SystemInfoApp.SystemHealthWidget": "系统状况",
    "SYNO.SDS.SystemInfoApp.ConnectionLogWidget": "目前连接用户",
    "SYNO.SDS.SystemInfoApp.StorageUsageWidget": "存储",
    "SYNO.SDS.ResourceMonitor.Widget": "资源监控",
  };
  List<String> selectedWidgets = [];
  List<String> get unselectedWidget => allWidgets.where((element) => !selectedWidgets.contains(element)).toList();
  @override
  void initState() {
    InitDataModel initData = context.read<InitDataProvider>().initData;
    if (initData.userSettings?.synoSDSWidgetInstance?.moduleList != null) {
      initData.userSettings!.synoSDSWidgetInstance!.moduleList!.forEach((element) {
        if (allWidgets.contains(element)) {
          selectedWidgets.add(element);
        }
      });
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = context.watch<SettingProvider>();
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("控制台设置"),
        actions: [
          CupertinoButton(
            onPressed: saving
                ? null
                : () async {
                    setState(() {
                      saving = true;
                    });
                    InitDataProvider initDataProvider = context.read<InitDataProvider>();
                    try {
                      bool? res = await initDataProvider.initData.userSettings?.apply(selectedWidgets);
                      if (res == true) {
                        initDataProvider.initData.userSettings?.synoSDSWidgetInstance?.moduleList = selectedWidgets;
                        initDataProvider.notify();
                        context.pop(true);
                      }
                    } on DsmException catch (e) {
                      Utils.vibrate(FeedbackType.error);
                      Utils.toast("保存小组件失败，代码${e.code}");
                    } finally {
                      setState(() {
                        saving = false;
                      });
                    }

                    // Map data = {
                    //   "SYNO.SDS._Widget.Instance": {"modulelist": selectedWidgets},
                    //   // "restoreSizePos": widget.restoreSizePos
                    // };
                    // var res = await Api.userSetting(data);
                    // if (res['success']) {
                    //   Utils.toast("保存小组件成功");
                    //   context.pop(true);
                    // } else {
                    //   Utils.toast("保存小组件失败，代码${res['error']['code']}");
                    // }
                  },
            child: saving
                ? LoadingWidget(
                    size: 24,
                  )
                : Image.asset(
                    "assets/icons/save.png",
                    width: 24,
                    height: 24,
                  ),
          ),
        ],
      ),
      body: ListView(
        children: [
          WidgetCard(
            title: "控制台设置",
            body: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "桌面快捷方式",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: settingProvider.showShortcut,
                          onChanged: (v) {
                            settingProvider.setShowShortcut(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (selectedWidgets.isNotEmpty)
            WidgetCard(
              title: "小组件排序",
              bodyPadding: EdgeInsets.symmetric(vertical: 14),
              body: ReorderableColumn(
                children: selectedWidgets.map((widget) {
                  return Container(
                    key: ValueKey(widget),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            name[widget],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedWidgets.remove(widget);
                            });
                          },
                          child: Image.asset(
                            "assets/icons/remove_circle_fill.png",
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                draggedItemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            name[selectedWidgets[index]],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Image.asset(
                          "assets/icons/move.png",
                          width: 24,
                          height: 24,
                          color: AppTheme.of(context)?.placeholderColor,
                        ),
                      ],
                    ),
                  );
                },
                onReorderStarted: (_) {
                  Utils.vibrate(FeedbackType.success);
                },
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  var child = selectedWidgets.removeAt(oldIndex);
                  selectedWidgets.insert(newIndex, child);

                  setState(() {});
                },
              ),
            ),
          WidgetCard(
            title: "可添加小组件",
            body: Column(
              children: unselectedWidget.map((widget) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          name[widget] ?? widget,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedWidgets.add(widget);
                          });
                        },
                        child: Image.asset(
                          "assets/icons/plus_circle.png",
                          width: 24,
                          height: 24,
                          color: AppTheme.of(context)?.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
