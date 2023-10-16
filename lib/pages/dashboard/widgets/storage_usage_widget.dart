import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/control_panel/info/info.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/volume_item_widget.dart';
import 'package:dsm_helper/providers/storage_provider.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StorageUsageWidget extends StatelessWidget {
  const StorageUsageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Storage storage = context.watch<StorageProvider>().storage;
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
                ...storage.volumes!.map((volume) => VolumeItemWidget(volume, isLast: storage.volumes!.last == volume)).toList()
              else
                EmptyWidget(
                  text: "暂无存储空间",
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
                ...storage.ssdCaches!.map((ssdCache) => VolumeItemWidget(ssdCache, isLast: storage.ssdCaches!.last == ssdCache)).toList(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
      ],
    );
  }
}
