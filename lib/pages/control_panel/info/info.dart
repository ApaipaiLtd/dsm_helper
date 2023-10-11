import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/providers/system_info_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class SystemInfo extends StatefulWidget {
  final int index;
  SystemInfo(this.index);
  @override
  _SystemInfoState createState() => _SystemInfoState();
}

class _SystemInfoState extends State<SystemInfo> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List usbDev = [];
  List nifs = [];
  List volumes = [];
  List disks = [];
  Map network = {};
  bool loadingDisks = false;
  @override
  void initState() {
    _tabController = TabController(initialIndex: widget.index, length: 5, vsync: this);
    // if (widget.system != null) {
    //   setState(() {
    //     usbDev = widget.system!['usb_dev'];
    //   });
    // }
    //
    // getData();
    // if (widget.volumes.length > 0 || widget.disks.length > 0) {
    //   setState(() {
    //     volumes = widget.volumes;
    //     disks = widget.disks;
    //   });
    // } else {
    //   setState(() {
    //     loadingDisks = true;
    //   });
    //   getDisks();
    // }
    super.initState();
  }

  getData() async {
    var res = await Api.networkInfo();
    if (res['success']) {
      setState(() {
        network = res['data'];
        nifs = network['nif'];
      });
      print(network);
    }
  }

  getDisks() async {
    var res = await Api.storage();
    if (res['success']) {
      setState(() {
        loadingDisks = false;
        volumes = res['data']['volumes'];
        volumes.sort((a, b) {
          return a['num_id'].compareTo(b['num_id']);
        });
        disks = res['data']['disks'];
      });
    }
  }

  Widget _buildNifItem(nif) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "局域网 ${nifs.indexOf(nif) + 1}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "MAC 地址",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "${nif['mac']}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "IP 地址",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "${nif['addr']}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "子网掩码",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "${nif['mask']}",
                    overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _buildDeviceItem(dev) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              dev['cls'] == "hub" ? "USB集线器" : dev['cls'],
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${dev['product']}${dev['producer']}",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeItem(volume) {
    double percent = int.parse(volume['size']['used']) / int.parse(volume['size']['total']);
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
              // progressColor: Colors.lightBlueAccent,
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
                      "存储空间 ${volume['num_id']}",
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
                Text("${volume['desc'] ?? (volume['vol_desc'] ?? "-")}"),
                SizedBox(
                  height: 5,
                ),
                Text("${Utils.formatSize(int.parse(volume['size']['used']))} / ${Utils.formatSize(int.parse(volume['size']['total']))}"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDiskItem(disk) {
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
              // color: Colors.red,
            ),
            child: Image.asset(
              disk['isSsd'] ? "assets/icons/ssd.png" : "assets/icons/hdd.png",
              width: 40,
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
                      "${disk['longName']}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Label(
                      disk['overview_status'] == "normal" ? "正常" : disk['overview_status'],
                      disk['overview_status'] == "normal" ? Colors.green : Colors.red,
                      fill: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text("${disk['vendor'].trim()} ${disk['model'].trim()}"),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text("${Utils.formatSize(int.parse(disk['size_total']))}"),
                    Text("  ${disk['temp']}℃"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    System system = context.read<SystemInfoProvider>().systemInfo;
    InitDataModel initData = context.watch<InitDataProvider>().initData;
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("信息中心"),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("常规"),
            ),
            Tab(
              child: Text("网络"),
            ),
            Tab(
              child: Text("存储"),
            ),
            Tab(
              child: Text("服务"),
            ),
            Tab(
              child: Text("设备分析"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [
              WidgetCard(
                title: "基本信息",
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "系统名称",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${initData.session?.hostname}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "DSM版本",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.firmwareVer}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              WidgetCard(
                title: "硬件信息",
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "产品序列号",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.serial ?? '-'}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "产品型号",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.model ?? '-'}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "CPU",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.cpuVendor} ${system.cpuFamily} ${system.cpuSeries}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "CPU核心",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.cpuCores}核 @ ${(system.cpuClockSpeed! / 1000).toStringAsFixed(2)}GHz",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "物理内存",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.ramSize}MB",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "DSM版本",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.firmwareVer}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "散热状态",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.sysTemp}℃ ${system.temperatureWarning == null ? (system.sysTemp! > 80 ? "警告" : "正常") : (system.temperatureWarning! ? "警告" : "正常")}",
                      style: TextStyle(color: system.temperatureWarning == null ? (system.sysTemp! > 80 ? AppTheme.of(context)?.errorColor : AppTheme.of(context)?.successColor) : (system.temperatureWarning! ? AppTheme.of(context)?.errorColor : AppTheme.of(context)?.successColor), fontSize: 16),
                    ),
                  ],
                ),
              ),
              WidgetCard(
                title: "时间信息",
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "服务器地址",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.ntpServer} ${system.enabledNtp! ? "" : "(暂未启用)"}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "时区",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.timeZoneDesc}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "系统时间",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${system.time}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "运行时间",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${Utils.parseOpTime(system.upTime!)}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              if (usbDev.length > 0)
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          "外接设备",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      ...usbDev.map(_buildDeviceItem).toList(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          network == null
              ? Center(
                  child: Text("网络信息加载失败"),
                )
              : ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              "基本信息",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "系统名称",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${network['hostname']}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "DNS",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${network['dns']}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "默认网关",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${network['gateway']}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "工作群组",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${network['workgroup']}",
                                    overflow: TextOverflow.ellipsis,
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
                    ...nifs.map(_buildNifItem).toList(),
                  ],
                ),
          loadingDisks
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
              : ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "存储空间",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          ...volumes.map(_buildVolumeItem).toList(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "硬盘",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          ...disks.map(_buildDiskItem).toList(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          Center(
            child: Text("待开发"),
          ),
          Center(
            child: Text("待开发"),
          ),
        ],
      ),
    );
  }
}
