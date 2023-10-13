import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/storage_manager/enums/disk_overview_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/enums/disk_smart_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/enums/disk_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/smart.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/disk_card_item_widget.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/storage_pool_item_widget.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/volume_item_widget.dart';
import 'package:dsm_helper/themes/app_theme.dart';
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
                    if (storage.disks != null)
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
                                decoration: storage.disks!.any((disk) => disk.numId == i + 1)
                                    ? BoxDecoration(
                                        color: AppTheme.of(context)?.primaryColor,
                                        border: Border.all(color: AppTheme.of(context)?.primaryColor ?? Colors.blue, width: 1),
                                      )
                                    : DashedDecoration(
                                        color: Colors.transparent,
                                        dashedColor: AppTheme.of(context)?.placeholderColor,
                                        gap: 2,
                                      ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
                storage.storagePools != null && storage.storagePools!.length > 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: ListView.separated(
                          itemBuilder: (context, i) {
                            var pool = storage.storagePools![i];
                            return StoragePoolItemWidget(
                              pool,
                              volumes: storage.volumes!.where((volumes) => volumes.poolPath == pool.id).toList(),
                              disks: storage.disks!.where((disk) => pool.disks!.contains(disk.id)).toList(),
                            );
                          },
                          itemCount: storage.storagePools!.length,
                          separatorBuilder: (context, i) {
                            return SizedBox(height: 10);
                          },
                        ),
                      )
                    : EmptyWidget(
                        text: "无存储池",
                      ),
                storage.disks != null && storage.disks!.length > 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: ListView.separated(
                          itemBuilder: (context, i) {
                            return DiskCardItemWidget(storage.disks![i]);
                          },
                          itemCount: storage.disks!.length,
                          separatorBuilder: (context, i) {
                            return SizedBox(height: 10);
                          },
                        ),
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
                        itemCount: ssdCaches.length,
                      )
                    : EmptyWidget(
                        text: "无SSD缓存",
                      ),
              ],
            ),
    );
  }
}
