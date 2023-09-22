import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/control_panel/info/info.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/storage_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StorageUsageWidget extends StatelessWidget {
  const StorageUsageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Storage storage = context.read<StorageProvider>().storage;
    return Column(
      children: [
        WidgetCard(
          onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
              return SystemInfo(2);
            }));
          },
          // icon: Image.asset(
          //   "assets/icons/pie.png",
          //   width: 26,
          //   height: 26,
          // ),
          title: "存储信息",
          body: Column(
            children: [
              if (storage.volumes != null)
                ...storage.volumes!.map((volume) => _buildVolumeItem(context, volume, isLast: storage.volumes!.last == volume)).toList()
              else
                Center(
                  child: Text(
                    "暂无存储空间",
                    style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                  ),
                ),
            ],
          ),
        ),
        if (storage.ssdCaches != null && storage.ssdCaches!.length > 0)
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
                ...storage.ssdCaches!.map((ssdCache) => _buildVolumeItem(context, ssdCache, isLast: storage.ssdCaches!.last == ssdCache)).toList(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
      ],
    );
  }

  Widget _buildVolumeItem(BuildContext context, Volumes volume, {bool isLast = false}) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${volume.displayName}",
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
              ),
              SizedBox(
                width: 5,
              ),
              volume.status == "normal"
                  ? Label(
                      "正常",
                      Colors.green,
                      fill: true,
                    )
                  : volume.status == "background"
                      ? Label(
                          "正在检查硬盘",
                          Colors.lightBlueAccent,
                          fill: true,
                        )
                      : volume.status == "attention"
                          ? Label(
                              "注意",
                              Colors.orangeAccent,
                              fill: true,
                            )
                          : Label(
                              volume.status!,
                              Colors.red,
                              fill: true,
                            ),
            ],
          ),
          Text(
            "${volume.size!.usedPercent.toStringAsFixed(1)}%",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                flex: volume.size!.used!,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: volume.size!.usedPercent > 80 ? Colors.red : Colors.blueAccent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 10,
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Expanded(
                flex: volume.size!.free!,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 10,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          DefaultTextStyle(
            style: TextStyle(fontSize: 12),
            child: Row(
              children: [
                Text(
                  "已用 ${Utils.formatSize(volume.size!.used!)} ",
                  style: TextStyle(color: volume.size!.usedPercent > 80 ? Colors.red : Colors.blueAccent),
                ),
                Text(
                  "/ ${Utils.formatSize(volume.size!.total!)}",
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                Text(
                  "可用：${Utils.formatSize(volume.size!.free!)}",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          if (!isLast)
            SizedBox(
              height: 20,
            ),
        ],
      ),
    );
  }
}
