import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/disk_item_widget.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/volume_item_widget.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class StorageTab extends StatefulWidget {
  const StorageTab({super.key});

  @override
  State<StorageTab> createState() => _StorageTabState();
}

class _StorageTabState extends State<StorageTab> {
  Storage storage = Storage();
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    // try {
    storage = await Storage.loadInfo();
    storage.storagePools?.sort((a, b) => a.numId!.compareTo(b.numId!));

    setState(() {
      loading = false;
    });
    // } on DsmException catch (e) {
    //   Utils.toast("获取存储空间信息失败，错误代码${e.code}");
    //   context.pop();
    // } catch (e) {
    //   Utils.toast("获取存储空间信息失败");
    //   context.pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget(
            size: 30,
          )
        : ListView(
            children: [
              if (storage.volumes != null && storage.volumes!.isNotEmpty)
                WidgetCard(
                  title: "存储空间",
                  body: Column(
                    children: storage.volumes!.map((volume) => VolumeItemWidget(volume)).toList(),
                  ),
                ),
              if (storage.disks != null && storage.disks!.isNotEmpty)
                WidgetCard(
                  title: "硬盘",
                  body: Column(
                    children: storage.disks!.map((disk) => DiskItemWidget(disk, isLast: storage.disks!.last == disk)).toList(),
                  ),
                ),
            ],
          );
  }
}
