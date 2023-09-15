import 'dart:async';

import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/utils/strings.dart';
import 'package:dsm_helper/widgets/bubble_tab_indicator.dart';
import 'package:dsm_helper/widgets/label.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskManager extends StatefulWidget {
  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List processes = [];
  List services = [];
  List slices = [];
  Timer? timer;
  bool loading = true;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getData();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getData();
    });
    super.initState();
  }

  getData() async {
    var process = await Api.process();
    var group = await Api.processGroup();
    if (process['success']) {
      setState(() {
        loading = false;
        try {
          processes = process['data']['process'];
          if (Utils.version == 7) {
            slices = group['data']['slices'];
          } else {
            services = group['data']['services'];
          }
        } catch (e) {}
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget _buildServiceItem(service) {
    String title = "";
    List<String> titles = service['display_name'].split(":");
    //判断是否在string内
    if (titles.length > 1) {
      if (webManagerStrings[titles[0]] != null && webManagerStrings[titles[0]][titles[1]] != null) {
        if (webManagerStrings[titles[0]][titles[1]] != null) {
          title = webManagerStrings[titles[0]][titles[1]];
        }
      } else if (Utils.strings[service['display_name']][titles[0]] != null && Utils.strings[service['display_name']][titles[0]][titles[1]] != null) {
        title = Utils.strings[service['display_name']][titles[0]][titles[1]];
      } else if (Utils.strings[service['display_name']] != null && Utils.strings[service['display_name']]['common'] != null && Utils.strings[service['display_name']]['common']['displayname'] != null) {
        title = Utils.strings[service['display_name']]['common']['displayname'];
      }
    } else {
      title = service['display_name'];
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ),
          // SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );
  }

  Widget _buildSliceItem(slice) {
    var cpuTime;
    if (slice['cpu_time'] is num) {
      cpuTime = Utils.timeLong(slice['cpu_time'].toInt());
    }
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${slice['name'] != '' ? slice['name'] : slice['name_i18n'] != '' ? slice['name_i18n'] : slice['unit_name']}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text("内存：${slice['memory'] is num ? Utils.formatSize(slice['memory'], fixed: 1) : slice['memory']}")
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: Text("CPU(%)：${slice['cpu_utilization'] is num ? slice['cpu_utilization'].toStringAsFixed(2) : slice['cpu_utilization']}")),
              Expanded(child: Text("CPU Time：${slice['cpu_time'] is String ? slice['cpu_time'] : '${cpuTime['hours']}:${cpuTime['minutes']}:${cpuTime['seconds']}'}")),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("读取(秒)：${slice['byte_read_per_sec'] is num ? Utils.formatSize(slice['byte_read_per_sec'], fixed: 1, showByte: true) : slice['byte_read_per_sec']}")),
              Expanded(child: Text("写入(秒)：${slice['byte_write_per_sec'] is num ? Utils.formatSize(slice['byte_write_per_sec'], fixed: 1, showByte: true) : slice['byte_write_per_sec']}")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProcessItem(process) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${process['command']}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              process['status'] == "R"
                  ? Label("运行中", Colors.green)
                  : process['status'] == "S"
                      ? Label("睡眠中", Colors.grey)
                      : Label(process['status'], Colors.red),
              SizedBox(
                width: 10,
              ),
              Text("CPU:${(process['cpu'] / 10).toStringAsFixed(1)}%"),
              SizedBox(
                width: 10,
              ),
              Text("PID:${process['pid']}"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: Text("私有内存：${Utils.formatSize(process['mem'] * 97, fixed: 1)}")),
              Expanded(child: Text("共享内存：${Utils.formatSize(process['mem_shared'] * 1024, fixed: 2)}")),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("任务管理器"),
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
          : Column(
              children: [
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicator: BubbleTabIndicator(
                      indicatorColor: Theme.of(context).scaffoldBackgroundColor,
                      shadowColor: Utils.getAdjustColor(Theme.of(context).scaffoldBackgroundColor, -20),
                    ),
                    tabs: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text("服务"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text("进程"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      if (Utils.version == 7)
                        ListView.builder(
                          padding: EdgeInsets.all(20),
                          itemBuilder: (context, i) {
                            return _buildSliceItem(slices[i]);
                          },
                          itemCount: slices.length,
                        )
                      else
                        ListView.builder(
                          padding: EdgeInsets.all(20),
                          itemBuilder: (context, i) {
                            return _buildServiceItem(services[i]);
                          },
                          itemCount: services.length,
                        ),
                      ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemBuilder: (context, i) {
                          return _buildProcessItem(processes[i]);
                        },
                        itemCount: processes.length,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
