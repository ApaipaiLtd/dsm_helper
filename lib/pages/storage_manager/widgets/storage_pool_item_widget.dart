import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/dashboard/enums/volume_status_enum.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/storage_manager/enums/storage_pool_device_type_enum.dart';
import 'package:dsm_helper/pages/storage_manager/enums/storage_pool_scrubbing_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/disk_item_widget.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/missing_drive_item_widget.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/volume_item_widget.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/expansion_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoragePoolItemWidget extends StatelessWidget {
  final StoragePools pool;
  final List<Volumes> volumes;
  final List<Disks> disks;
  const StoragePoolItemWidget(this.pool, {required this.volumes, required this.disks, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: ExpansionContainer(
        childrenPadding: EdgeInsets.zero,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "存储池 ${pool.numId}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: pool.statusEnum.color,
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(right: 3),
                ),
                Text(
                  pool.statusEnum != VolumeStatusEnum.unknown ? "${pool.statusEnum.label}${pool.statusEnum == VolumeStatusEnum.background_scrubbing ? '：${pool.progress?.percent ?? '-'}%' : ''}" : pool.status!,
                  style: TextStyle(color: pool.statusEnum.color, fontSize: 12),
                ),
                SizedBox(width: 10),
                if (pool.size != null)
                  Text.rich(
                    //${Utils.formatSize(pool.size!.used!)} /
                    TextSpan(children: [
                      TextSpan(
                        text: "${Utils.formatSize(pool.size!.total!, showByte: true)}已分配",
                      ),
                      TextSpan(text: " | ${Utils.formatSize(pool.size!.free!, showByte: true)}可用", style: TextStyle(color: AppTheme.of(context)?.placeholderColor)),
                    ]),
                    style: TextStyle(color: AppTheme.of(context)?.primaryColor, fontSize: 12),
                  ),
              ],
            ),
          ],
        ),
        children: [
          WidgetCard(
            title: "信息",
            boxDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 14),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "RAID类别",
                  style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: pool.deviceTypeEnum != StoragePoolDeviceTypeEnum.unknown
                            ? pool.deviceTypeEnum.label
                            : pool.deviceType == "shr_without_disk_protect" || pool.deviceType == "shr"
                                ? "Synology Hybrid RAID (SHR) "
                                : pool.deviceType,
                      ),
                      TextSpan(
                        text: "（${pool.deviceTypeEnum.protect ? '有' : '无'}数据保护）",
                        style: TextStyle(color: pool.deviceTypeEnum.protect ? AppTheme.of(context)?.primaryColor : AppTheme.of(context)?.errorColor),
                      ),
                    ],
                  ),
                  style: TextStyle(fontSize: 16),
                ),
                Divider(indent: 0, endIndent: 0, height: 20),
                Text(
                  "支持多个存储空间",
                  style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                ),
                Text(
                  "${pool.raidType == 'single' ? '否' : '是'}",
                  style: TextStyle(fontSize: 16),
                ),
                // Divider(indent: 0, endIndent: 0, height: 20),
                // Text(
                //   "存储空间加密",
                //   style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                // ),
                // Text(
                //   "${pool.i == 'single' ? '否' : '是'}",
                //   style: TextStyle(fontSize: 16),
                // ),
              ],
            ),
          ),
          WidgetCard(
            title: "数据清理",
            boxDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 14),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "数据清理",
                            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                          ),
                          if (pool.isScheduled == true)
                            Text(
                              "${pool.scrubbingStatusEnum == StoragePoolScrubbingStatusEnum.schedule_done ? "已计划于${DateTime.fromMillisecondsSinceEpoch(pool.nextScheduleTime!.toInt() * 1000).format("Y-m-d")}" : '${pool.scrubbingStatus}'}",
                              style: TextStyle(fontSize: 16),
                            )
                          else
                            Text(
                              "${pool.scrubbingStatusEnum != StoragePoolScrubbingStatusEnum.unknown ? pool.scrubbingStatusEnum.label : '${pool.scrubbingStatus}'}",
                              style: TextStyle(fontSize: 16),
                            ),
                        ],
                      ),
                    ),
                    if ([StoragePoolScrubbingStatusEnum.ready, StoragePoolScrubbingStatusEnum.schedule_done].contains(pool.scrubbingStatusEnum))
                      CupertinoButton(
                        onPressed: () async {},
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          "assets/icons/play_circle_fill.png",
                          width: 24,
                        ),
                      )
                    else ...[
                      CupertinoButton(
                        onPressed: () async {},
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          "assets/icons/pause_circle_fill.png",
                          width: 24,
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () async {},
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          "assets/icons/remove_circle_fill.png",
                          width: 24,
                        ),
                      )
                    ],
                  ],
                ),
                Divider(indent: 0, endIndent: 0, height: 20),
                Text(
                  "完成时间",
                  style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                ),
                Text(
                  "${pool.lastDoneTime != null && pool.lastDoneTime! > 0 ? DateTime.fromMillisecondsSinceEpoch(pool.lastDoneTime!.toInt() * 1000).format("Y-m-d H:i") : "从未执行"}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          if (pool.missingDrives != null && pool.missingDrives!.isNotEmpty)
            WidgetCard(
              title: "必需硬盘信息",
              boxDecoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 14),
              body: Column(
                children: pool.missingDrives!.map((drive) => MissingDriveItemWidget(drive, isLast: pool.missingDrives!.last == drive)).toList(),
              ),
            ),
          WidgetCard(
            title: "硬盘信息",
            boxDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 14),
            body: Column(
              children: disks.map((disk) => DiskItemWidget(disk, showStatus: true, isLast: disks.last == disk)).toList(),
            ),
          ),
          WidgetCard(
            boxDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 14),
            title: "存储分配",
            body: Column(
              children: volumes.map((volume) => VolumeItemWidget(volume, showFileSystem: true)).toList(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
