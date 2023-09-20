import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:dsm_helper/models/setting/group_model.dart';
import 'package:dsm_helper/models/wallpaper_model.dart';
import 'package:dsm_helper/pages/control_panel/external_device/external_device.dart';
import 'package:dsm_helper/pages/control_panel/info/info.dart';
import 'package:dsm_helper/pages/control_panel/task_scheduler/task_scheduler.dart';
import 'package:dsm_helper/pages/dashboard/applications.dart';
import 'package:dsm_helper/pages/dashboard/media_converter.dart';
import 'package:dsm_helper/pages/dashboard/shortcut_list.dart';
import 'package:dsm_helper/pages/dashboard/widget_setting.dart';
import 'package:dsm_helper/pages/dashboard/widgets/system_health_widget.dart';
import 'package:dsm_helper/pages/log_center/log_center.dart';
import 'package:dsm_helper/pages/notify/notify.dart';
import 'package:dsm_helper/pages/resource_monitor/performance.dart';
import 'package:dsm_helper/pages/resource_monitor/resource_monitor.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/providers/setting.dart';
import 'package:dsm_helper/providers/shortcut.dart';
import 'package:dsm_helper/providers/system_info_provider.dart';
import 'package:dsm_helper/providers/utilization_provider.dart';
import 'package:dsm_helper/providers/wallpaper.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/utils/log.dart';
import 'package:dsm_helper/widgets/animation_progress_bar.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:dsm_helper/apis/api.dart' as api;

class Dashboard extends StatefulWidget {
  Dashboard({key}) : super(key: key);
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map? utilization;
  List volumes = [];
  List disks = [];
  List connectedUsers = [];
  List interfaces = [];
  List networks = [];
  List ssdCaches = [];
  List tasks = [];
  List latestLog = [];
  List notifies = [];
  List applications = [];
  List fileLogs = [];
  List validAppViewOrder = [];
  WallpaperModel? wallpaperModel;
  List esatas = [];
  List usbs = [];
  Map? appNotify;
  Map? system;
  Map? restoreSizePos;
  Map? converter;
  Map? volWarnings;
  bool loading = true;
  bool success = true;
  int refreshDuration = 10;
  String hostname = "获取中";
  int get maxNetworkSpeed {
    int maxSpeed = 0;
    for (int i = 0; i < networks.length; i++) {
      int maxVal = max(networks[i]['rx'], networks[i]['tx']);
      if (maxSpeed < maxVal) {
        maxSpeed = maxVal;
      }
    }
    return maxSpeed;
  }

  String msg = "";
  @override
  void initState() {
    getGroups();
    networks = List.generate(20, (i) => {"tx": 0, "rx": 0});
    getNotifyStrings();
    // ApiModel.fetch().then((apis) {
    //   Api.apiList = apis;
    // });
    getData(init: true);
    super.initState();
  }

  bool get isDrawerOpen {
    return _scaffoldKey.currentState!.isDrawerOpen;
  }

  getGroups() async {
    Utils.groups = await GroupsModel.fetch();
    if (Utils.notReviewAccount) {
      showFirstLaunchDialog();
    }
  }

  closeDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.of(context).pop();
    }
  }

  showFirstLaunchDialog() async {
    bool firstLaunch = SpUtil.getBool("first_launch_channel", defValue: true)!;
    if (firstLaunch) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "温馨提示",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Text("前往'设置-关闭广告'页面，即可关闭开屏广告。"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: Utils.groups.channel!.map((channel) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/qq.png",
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${channel.displayName}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Spacer(),
                                        CupertinoButton(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                          onPressed: () {
                                            launchUrlString(channel.key!, mode: LaunchMode.externalApplication);
                                          },
                                          child: Text("加入"),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: Utils.groups.wechat!.map((wechat) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/wechat.png",
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${wechat.displayName}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Spacer(),
                                        CupertinoButton(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(20),
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                          onPressed: () {
                                            ClipboardData data = new ClipboardData(text: wechat.name!);
                                            Clipboard.setData(data);
                                            Utils.toast("已复制到剪贴板");
                                          },
                                          child: Text("复制"),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CupertinoButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  SpUtil.putBool("first_launch_channel", false);
                                },
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(25),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "我知道了",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  getNotifyStrings() async {
    var res = await Api.notifyStrings();
    debugPrint("notifyStrings");
    if (res['success']) {
      setState(() {
        Utils.notifyStrings = res['data'] ?? {};
      });
    }
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

  getData({bool init = false}) async {
    // getExternalDevice();
    // getMediaConverter();
    InitDataModel initData = await InitDataModel.get();
    InitDataProvider initDataProvider = context.read<InitDataProvider>();
    initDataProvider.setInitData(initData);
    setState(() {});
    var batchRes = await api.Api.dsm.batch(apis: [System()]);
    if (batchRes['success']) {
      List res = batchRes['data']['result'];
      res.forEach((element) {
        switch (element['api']) {
          case "SYNO.Core.System":
            setState(() {
              SystemInfoProvider provider = context.read<SystemInfoProvider>();
              provider.setSystemInfo(System.fromJson(element['data']));
            });
            break;
        }
      });
      setState(() {
        loading = false;
        success = true;
      });
    }
    UtilizationProvider utilizationProvider = context.read<UtilizationProvider>();
    Utilization utilization = await Utilization.get();
    utilizationProvider.setUtilization(utilization);
    print(utilization);

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
    } else if (widget == "SYNO.SDS.SystemInfoApp.ConnectionLogWidget" && connectedUsers.length > 0) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/user.png",
                    width: 26,
                    height: 26,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "登录用户",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            ...connectedUsers.map(_buildUserItem).toList(),
          ],
        ),
      );
    } else if (widget == "SYNO.SDS.TaskScheduler.TaskSchedulerWidget") {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return TaskScheduler();
          }));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/task.png",
                      width: 26,
                      height: 26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "计划任务",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ...tasks.map(_buildTaskItem).toList(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    } else if (widget == "SYNO.SDS.SystemInfoApp.RecentLogWidget") {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) {
                return LogCenter();
              },
              settings: RouteSettings(name: "log_center"),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/log.png",
                      width: 26,
                      height: 26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "最新日志",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                child: latestLog.length > 0
                    ? CupertinoScrollbar(
                        child: ListView.builder(
                          itemBuilder: (context, i) {
                            return _buildLogItem(latestLog[i]);
                          },
                          itemCount: latestLog.length,
                        ),
                      )
                    : Center(
                        child: Text(
                          "暂无日志",
                          style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    } else if (widget == "SYNO.SDS.ResourceMonitor.Widget") {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return ResourceMonitor();
          }));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/resources.png",
                      width: 26,
                      height: 26,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "资源监控",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              if (utilization != null) ...[
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) {
                          return Performance(
                            tabIndex: 1,
                          );
                        },
                        settings: RouteSettings(name: "performance")));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Text("CPU："),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FAProgressBar(
                              backgroundColor: Colors.transparent,
                              changeColorValue: 90,
                              changeProgressColor: Colors.red,
                              progressColor: Colors.blue,
                              displayTextStyle: TextStyle(color: AppTheme.of(context)?.progressColor, fontSize: 12),
                              currentValue: utilization!['cpu']['user_load'] + utilization!['cpu']['system_load'],
                              displayText: '%',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) {
                          return Performance(
                            tabIndex: 2,
                          );
                        },
                        settings: RouteSettings(name: "performance")));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(width: 60, child: Text("RAM：")),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FAProgressBar(
                              backgroundColor: Colors.transparent,
                              changeColorValue: 90,
                              changeProgressColor: Colors.red,
                              progressColor: Colors.blue,
                              displayTextStyle: TextStyle(color: AppTheme.of(context)?.progressColor, fontSize: 12),
                              currentValue: utilization!['memory']['real_usage'],
                              displayText: '%',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) {
                          return Performance(
                            tabIndex: 3,
                          );
                        },
                        settings: RouteSettings(name: "performance")));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(width: 60, child: Text("网络：")),
                        Icon(
                          Icons.upload_sharp,
                          color: Colors.blue,
                        ),
                        Text(
                          Utils.formatSize(utilization!['network'][0]['tx']) + "/S",
                          style: TextStyle(color: Colors.blue),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.download_sharp,
                          color: Colors.green,
                        ),
                        Text(
                          Utils.formatSize(utilization!['network'][0]['rx']) + "/S",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) {
                          return Performance(
                            tabIndex: 3,
                          );
                        },
                        settings: RouteSettings(name: "performance")));
                  },
                  child: AspectRatio(
                    aspectRatio: 1.70,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: LineChart(
                            LineChartData(
                              lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor: Colors.white.withOpacity(0.6),
                                  tooltipRoundedRadius: 20,
                                  fitInsideHorizontally: true,
                                  fitInsideVertically: true,
                                  getTooltipItems: (List<LineBarSpot> items) {
                                    return items.map((LineBarSpot touchedSpot) {
                                      final textStyle = TextStyle(
                                        color: touchedSpot.bar.color,
                                        // color: touchedSpot.bar.colors[0],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      );
                                      return LineTooltipItem('${touchedSpot.bar.color == Colors.blue ? "上传" : "下载"}:${Utils.formatSize(touchedSpot.y.floor())}', textStyle);
                                    }).toList();
                                  },
                                ),
                              ),
                              gridData: FlGridData(
                                show: false,
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: false,
                                    reservedSize: 22,
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    // getTextStyles: (value, _) => const TextStyle(
                                    //   color: Color(0xff67727d),
                                    //   fontSize: 12,
                                    // ),
                                    // getTitles: chartTitle,
                                    getTitlesWidget: (value, _) {
                                      return Text(Utils.formatSize(value, fixed: 0),
                                          style: TextStyle(
                                            color: Color(0xff67727d),
                                            fontSize: 12,
                                          ));
                                    },
                                    reservedSize: 35,
                                    interval: Utils.chartInterval(maxNetworkSpeed),
                                  ),
                                ),
                              ),
                              // maxY: 20,
                              minY: 0,
                              borderData: FlBorderData(show: true, border: Border.all(color: Colors.black12, width: 1)),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: networks.map((network) {
                                    return FlSpot(networks.indexOf(network).toDouble(), network['tx'].toDouble());
                                  }).toList(),
                                  isCurved: true,
                                  color: Colors.blue,
                                  barWidth: 2,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(
                                    show: false,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.blue.withOpacity(0.2),
                                  ),
                                ),
                                LineChartBarData(
                                  spots: networks.map((network) {
                                    return FlSpot(networks.indexOf(network).toDouble(), network['rx'].toDouble());
                                  }).toList(),
                                  isCurved: true,
                                  color: Colors.green,
                                  barWidth: 2,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(
                                    show: false,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.green.withOpacity(0.2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else
                SizedBox(
                  height: 300,
                  child: Center(child: Text("数据加载失败")),
                ),
            ],
          ),
        ),
      );
    } else if (widget == "SYNO.SDS.SystemInfoApp.StorageUsageWidget") {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                return SystemInfo(2, system!, volumes, disks);
              }));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/pie.png",
                          width: 26,
                          height: 26,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "存储",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  ...volumes.map(_buildVolumeItem).toList(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          if (ssdCaches.length > 0)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/cache.png",
                          width: 26,
                          height: 26,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "缓存",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  ...ssdCaches.map(_buildSSDCacheItem).toList(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
        ],
      );
    } else if (widget == "SYNO.SDS.SystemInfoApp.FileChangeLogWidget") {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/file_change.png",
                    width: 26,
                    height: 26,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "文件更改日志",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: fileLogs.length > 0
                  ? CupertinoScrollbar(
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return _buildFileLogItem(fileLogs[i]);
                        },
                        itemCount: fileLogs.length,
                      ),
                    )
                  : Center(
                      child: Text(
                        "暂无日志",
                        style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                      ),
                    ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildUserItem(user) {
    user['running'] = user['running'] ?? false;
    DateTime loginTime = DateTime.parse(user['time'].toString().replaceAll("/", "-"));
    DateTime currentTime = DateTime.now();
    Map timeLong = Utils.timeLong(currentTime.difference(loginTime).inSeconds);
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${user['who']}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              "${user['type']}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              "${timeLong['hours'].toString().padLeft(2, "0")}:${timeLong['minutes'].toString().padLeft(2, "0")}:${timeLong['seconds'].toString().padLeft(2, "0")}",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          CupertinoButton(
            onPressed: () async {
              if (user['running']) {
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
                                "终止连接",
                                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "确认要终止此连接？",
                                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
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
                                          user['running'] = true;
                                        });
                                        var res = await Api.kickConnection({"who": user['who'], "from": user['from']});
                                        setState(() {
                                          user['running'] = false;
                                        });

                                        if (res['success']) {
                                          Utils.toast("连接已终止");
                                        }
                                      },
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(25),
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        "终止连接",
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
            },
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: 20,
              height: 20,
              child: user['running']
                  ? CupertinoActivityIndicator()
                  : Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                      size: 18,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(task) {
    task['running'] = task['running'] ?? false;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "${task['name']}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "${task['next_trigger_time']}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: 5,
            ),
            CupertinoButton(
              onPressed: () async {
                if (task['running']) {
                  return;
                }
                setState(() {
                  task['running'] = true;
                });
                var res = await Api.taskRun([task['id']]);
                setState(() {
                  task['running'] = false;
                });
                if (res['success']) {
                  Utils.toast("任务计划执行成功");
                } else {
                  Utils.toast("任务计划执行失败，code：${res['error']['code']}");
                }
              },
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              padding: EdgeInsets.all(5),
              child: SizedBox(
                width: 20,
                height: 20,
                child: task['running']
                    ? CupertinoActivityIndicator()
                    : Icon(
                        CupertinoIcons.play_arrow_solid,
                        color: Color(0xffff9813),
                        size: 16,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(log) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${log['ldate']} ${log['ltime']}"),
          Text(
            "${log['msg']}",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildFileLogItem(log) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Icon(log['cmd'] == "delete"
              ? Icons.delete
              : log['cmd'] == "copy"
                  ? Icons.copy
                  : log['cmd'] == "edit"
                      ? Icons.edit
                      : log['cmd'] == "move"
                          ? Icons.drive_file_move_outline
                          : log['cmd'] == "download"
                              ? Icons.download_outlined
                              : log['cmd'] == "upload"
                                  ? Icons.upload_outlined
                                  : log['cmd'] == "rename"
                                      ? Icons.drive_file_rename_outline
                                      : log['cmd'] == "write"
                                          ? Icons.edit
                                          : log['cmd'] == 'create'
                                              ? Icons.add
                                              : Icons.device_unknown),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${log['time']}",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "${log['descr']}",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeItem(volume) {
    double used = int.parse(volume['size']['used']) / int.parse(volume['size']['total']);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(80),
              // color: Colors.red,
            ),
            padding: EdgeInsets.all(5),
            child: CircularPercentIndicator(
              radius: 40,
              animation: true,
              linearGradient: LinearGradient(
                colors: used <= 0.9
                    ? [
                        Colors.blue,
                        Colors.blueAccent,
                      ]
                    : [
                        Colors.red,
                        Colors.orangeAccent,
                      ],
              ),
              animateFromLastPercent: true,
              circularStrokeCap: CircularStrokeCap.round,
              lineWidth: 12,
              backgroundColor: Colors.black12,
              percent: used,
              center: Text(
                "${(used * 100).toStringAsFixed(0)}%",
                style: TextStyle(color: used <= 0.9 ? Colors.blue : Colors.red, fontSize: 22),
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
                Row(
                  children: [
                    Text(
                      "${volume['deploy_path'] != null ? volume['deploy_path'].toString().replaceFirst("volume_", "存储空间 ") : volume['id'].toString().replaceFirst("volume_", "存储空间 ")}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    volume['status'] == "normal"
                        ? Label(
                            "正常",
                            Colors.green,
                            fill: true,
                          )
                        : volume['status'] == "background"
                            ? Label(
                                "正在检查硬盘",
                                Colors.lightBlueAccent,
                                fill: true,
                              )
                            : volume['status'] == "attention"
                                ? Label(
                                    "注意",
                                    Colors.orangeAccent,
                                    fill: true,
                                  )
                                : Label(
                                    volume['status'],
                                    Colors.red,
                                    fill: true,
                                  ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text("已用：${Utils.formatSize(int.parse(volume['size']['used']))}"),
                SizedBox(
                  height: 5,
                ),
                Text("可用：${Utils.formatSize(int.parse(volume['size']['total']) - int.parse(volume['size']['used']))}"),
                SizedBox(
                  height: 5,
                ),
                Text("容量：${Utils.formatSize(int.parse(volume['size']['total']))}"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSSDCacheItem(volume) {
    double percent = int.parse(volume['size']['used'] ?? volume['size']['reusable']) / int.parse(volume['size']['total']);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(80),
              // color: Colors.red,
            ),
            padding: EdgeInsets.all(5),
            child: CircularPercentIndicator(
              radius: 40,
              animation: true,
              linearGradient: LinearGradient(
                colors: percent <= 0.9
                    ? [
                        Colors.blue,
                        Colors.blueAccent,
                      ]
                    : [
                        Colors.red,
                        Colors.orangeAccent,
                      ],
              ),
              animateFromLastPercent: true,
              circularStrokeCap: CircularStrokeCap.round,
              lineWidth: 12,
              backgroundColor: Colors.black12,
              percent: percent,
              center: Text(
                "${(percent * 100).toStringAsFixed(0)}%",
                style: TextStyle(color: percent <= 0.9 ? Colors.blue : Colors.red, fontSize: 22),
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
                Row(
                  children: [
                    Text(
                      "${volume['id'].toString().replaceFirst("ssd_", "SSD 缓存 ")}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    volume['status'] == "normal"
                        ? Label(
                            "正常",
                            Colors.green,
                            fill: true,
                          )
                        : volume['status'] == "background"
                            ? Label(
                                "正在检查硬盘",
                                Colors.lightBlueAccent,
                                fill: true,
                              )
                            : volume['status'] == "attention"
                                ? Label(
                                    "注意",
                                    Colors.orangeAccent,
                                    fill: true,
                                  )
                                : Label(
                                    volume['status'],
                                    Colors.red,
                                    fill: true,
                                  ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text("已用：${Utils.formatSize(int.parse(volume['size']['used'] ?? volume['size']['reusable']))}"),
                SizedBox(
                  height: 5,
                ),
                Text("可用：${Utils.formatSize(int.parse(volume['size']['total']) - int.parse(volume['size']['used'] ?? volume['size']['reusable']))}"),
                SizedBox(
                  height: 5,
                ),
                Text("容量：${Utils.formatSize(int.parse(volume['size']['total']))}"),
              ],
            ),
          )
        ],
      ),
    );
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                if (Utils.notReviewAccount)
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: CupertinoButton(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Image.asset(
                        "assets/icons/application.png",
                        width: 20,
                      ),
                    ),
                  ),
                if ((esatas + usbs).length > 0)
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: CupertinoButton(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.all(10),
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
                        width: 20,
                      ),
                    ),
                  ),
                if (converter != null && (converter!['photo_remain'] + converter!['thumb_remain'] + converter!['video_remain'] > 0))
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: CupertinoButton(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return MediaConverter(converter!);
                            });
                      },
                      child: Image.asset(
                        "assets/icons/converter.gif",
                        width: 20,
                      ),
                    ),
                  ),
                Spacer(),
                if (Utils.notReviewAccount)
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: CupertinoButton(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        // Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                        //   return WidgetSetting(widgets, restoreSizePos!);
                        // })).then((res) {
                        //   if (res != null) {
                        //     setState(() {
                        //       widgets = res;
                        //       getData();
                        //     });
                        //   }
                        // });
                      },
                      child: Image.asset(
                        "assets/icons/edit.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: CupertinoButton(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      Navigator.of(context)
                          .push(CupertinoPageRoute(
                              builder: (context) {
                                return Notify(notifies);
                              },
                              settings: RouteSettings(name: "notify")))
                          .then((res) {
                        if (res != null && res) {
                          setState(() {
                            notifies = [];
                          });
                        }
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          "assets/icons/message.png",
                          width: 20,
                          height: 20,
                        ),
                        if (notifies.length > 0)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 5,
                            height: 5,
                          )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text("控制台")
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: loading
          ? Center(
              child: Container(
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CupertinoActivityIndicator(
                  radius: 14,
                ),
              ),
            )
          : success
              ? ListView(
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                                  // Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                                  //   return WidgetSetting(widgets, restoreSizePos!);
                                  // })).then((res) {
                                  //   if (res != null) {
                                  //     setState(() {
                                  //       widgets = res;
                                  //       getData();
                                  //     });
                                  //   }
                                  // });
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
      drawer: applications.length > 0 ? ApplicationList(applications, system, volumes, disks, appNotify) : null,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          getData();
        },
      ),
    );
  }
}
