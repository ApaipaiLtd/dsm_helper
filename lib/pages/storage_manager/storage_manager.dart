import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/storage_manager/smart.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/storage_pool_item_widget.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/volume_item_widget.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/dashed_decoration.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class StorageManager extends StatefulWidget {
  @override
  _StorageManagerState createState() => _StorageManagerState();
}

class _StorageManagerState extends State<StorageManager> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Storage storage = Storage();
  bool loading = true;
  List ssdCaches = [];
  List disks = [];
  List storagePools = [];
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    getData();
    super.initState();
  }

  getData() async {
    try {
      storage = await Storage.loadInfo();
      storage.storagePools?.sort((a, b) => a.numId!.compareTo(b.numId!));

      setState(() {
        loading = false;
      });
    } on DsmException catch (e) {
      Utils.toast("获取存储空间信息失败，错误代码${e.code}");
      context.pop();
    } catch (e) {
      Utils.toast("获取存储空间信息失败");
      context.pop();
    }
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
                      "${volume['id'].toString().replaceFirst("ssd_", "SSD 缓存 ")}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Label(
                      volume['status'] == "normal" ? "正常" : volume['status'],
                      volume['status'] == "normal" ? Colors.green : Colors.red,
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

  Widget _buildDiskItem(disk, {bool full = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) {
              return Smart(disk);
            },
            settings: RouteSettings(name: "disk_smart")));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
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
                            "${disk['longName'].replaceAll("Cache device", "缓存设备")}",
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
                          SizedBox(
                            width: 5,
                          ),
                          if (disk['temp'] != null && disk['temp'] > -1)
                            Label(
                              "${disk['temp']}℃",
                              Colors.lightBlueAccent,
                              height: 23,
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
                      Text("${Utils.formatSize(int.parse(disk['size_total']))}"),
                    ],
                  ),
                )
              ],
            ),
            if (full) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            "位置",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text("${disk['container']['str']}"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            "硬盘类型",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text("${disk['diskType']}"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            "存储池",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        if (storagePools.where((pool) => pool['id'] == disk['used_by']).toList().length > 0)
                          Text("存储池 ${storagePools.where((pool) => pool['id'] == disk['used_by']).toList()[0]['num_id']}")
                        else if (ssdCaches.where((ssd) => ssd['id'] == disk['used_by']).toList().length > 0)
                          Text("${ssdCaches.where((ssd) => ssd['id'] == disk['used_by']).toList()[0]['id'].toString().replaceFirst("ssd_", "SSD 缓存 ")}")
                        else
                          Text("-"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            "硬盘分配状态",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          "${disk['status'] == "normal" ? "正常" : disk['status'] == "not_use" ? "未初始化" : disk['status'] == "sys_partition_normal" ? "已初始化" : "${disk['status']}"}",
                          style: TextStyle(color: disk['status'] == "normal" ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            "健康状态",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          "${disk['smart_status'] == "normal" ? "正常" : disk['smart_status']}",
                          style: TextStyle(color: disk['smart_status'] == "normal" ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (disk['remain_life'] != null) ...[
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "预计寿命",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text("${disk['remain_life'] == -1 ? "-" : disk['remain_life']}"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                    if (disk['unc'] != null && disk['unc'] > -1) ...[
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "坏扇区数量",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text("${disk['unc']}"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                    if (disk['temp'] != null) ...[
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "温度",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text("${disk['temp'] > -1 ? "${disk['temp']} ℃" : "-"}"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                    if (disk['serial'] != null) ...[
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "序列号",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text("${disk['serial']}"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                    if (disk['firm'] != null) ...[
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "固件版本",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text("${disk['firm']}"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                    if (disk['is4Kn'] != null)
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "4K原生硬盘",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text("${disk['is4Kn'] ? "是" : "否"}"),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPoolDetail(pool) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "存储池 ${pool['num_id']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 5,
                ),
                pool['status'] == "normal"
                    ? Label(
                        "正常",
                        Colors.green,
                        fill: true,
                      )
                    : pool['status'] == "background"
                        ? Label(
                            "正在检查硬盘",
                            Colors.lightBlueAccent,
                            fill: true,
                          )
                        : pool['status'] == "attention"
                            ? Label(
                                "注意",
                                Colors.orangeAccent,
                                fill: true,
                              )
                            : Label(
                                pool['status'],
                                Colors.red,
                                fill: true,
                              ),
                Spacer(),
                Text("${Utils.formatSize(int.parse(pool['size']['used']))} / ${Utils.formatSize(int.parse(pool['size']['total']))}"),
              ],
            ),
            Row(
              children: [
                Text(
                  pool['device_type'] == "basic"
                      ? "Basic"
                      : pool['device_type'] == "shr_without_disk_protect" || pool['device_type'] == "shr"
                          ? "Synology Hybrid RAID (SHR) "
                          : pool['device_type'],
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (pool['device_type'] == "basic" || pool['device_type'] == "shr_without_disk_protect")
                  Text(
                    "（无数据保护）",
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    "支持多个存储空间",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Text("${pool['raidType'] == "single" ? "否" : "是"}")
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    "可用容量",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Text("${Utils.formatSize(int.parse(pool['size']['total']) - int.parse(pool['size']['used']))}"),
              ],
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
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "硬盘信息",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    ...disks.where((e) => pool['disks'].contains(e['id'])).map(_buildDiskItem).toList(),
                  ],
                ),
              ),
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
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "可用Hot Spare硬盘",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("${pool['spares'] == null || pool['spares'].length == 0 ? "系统中无备援配置" : "暂不支持显示，共${pool['spares'].length}块"}"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
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
                      "存储分配",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  // ...volumes.where((e) => e['pool_path'] == pool['id']).map(_buildVolumeItem).toList(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("存储管理器"),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("总览"),
            ),
            Tab(
              child: Text("存储空间"),
            ),
            Tab(
              child: Text("HDD/SSD"),
            ),
            Tab(
              child: Text("SSD 缓存"),
            ),
          ],
        ),
      ),
      body: loading
          ? Center(
              child: LoadingWidget(size: 30),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    if (storage.volumes != null && storage.volumes!.length > 0)
                      WidgetCard(
                        title: "存储空间使用状况",
                        body: Column(
                          children: storage.volumes!.map((volume) => VolumeItemWidget(volume, isLast: storage.volumes!.last == volume)).toList(),
                        ),
                      ),
                    WidgetCard(
                      title: "硬盘信息",
                      body: Wrap(
                        runSpacing: 5,
                        spacing: 5,
                        children: [
                          for (int i = 0; i < (storage.env?.bayNumber != null ? int.parse(storage.env!.bayNumber!) : 8); i++)
                            Container(
                              height: 20,
                              width: 40,
                              decoration: DashedDecoration(
                                color: disks.where((disk) => disk['num_id'] == i + 1).length > 0 ? Colors.blue : Colors.transparent,
                                dashedColor: disks.where((disk) => disk['num_id'] == i + 1).length > 0 ? Colors.blue : Colors.grey,
                                gap: disks.where((disk) => disk['num_id'] == i + 1).length > 0 ? 0.1 : 2,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                storage.storagePools != null && storage.storagePools!.length > 0
                    ? ListView.separated(
                        itemBuilder: (context, i) {
                          var pool = storage.storagePools![i];
                          return StoragePoolItemWidget(
                            pool,
                            volumes: [],
                            disks: storage.disks!.where((disk) => pool.disks!.contains(disk.id)).toList(),
                          );
                        },
                        itemCount: storage.storagePools!.length,
                        separatorBuilder: (context, i) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                      )
                    : EmptyWidget(
                        text: "无存储池",
                      ),
                disks.length > 0
                    ? ListView.separated(
                        padding: EdgeInsets.all(20),
                        itemBuilder: (context, i) {
                          return _buildDiskItem(disks[i], full: true);
                        },
                        itemCount: disks.length,
                        separatorBuilder: (context, i) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                      )
                    : EmptyWidget(
                        text: "无HDD/SSD",
                      ),
                ssdCaches.length > 0
                    ? ListView.separated(
                        itemBuilder: (context, i) {
                          return _buildSSDCacheItem(ssdCaches[i]);
                        },
                        separatorBuilder: (context, i) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: ssdCaches.length)
                    : EmptyWidget(
                        text: "无SSD缓存",
                      ),
              ],
            ),
    );
  }
}
