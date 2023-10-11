import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/dashboard/enums/volume_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/disk_item_widget.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/expansion_container.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoragePoolItemWidget extends StatelessWidget {
  final StoragePools pool;
  final List<Volumes> volumes;
  final List<Disks> disks;
  const StoragePoolItemWidget(this.pool, {required this.volumes, required this.disks, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionContainer(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      title: Row(
        children: [
          pool.statusEnum != VolumeStatusEnum.unknown
              ? Label(
                  pool.statusEnum.label,
                  pool.statusEnum.color,
                  fill: true,
                )
              : Label(
                  pool.status!,
                  Colors.red,
                  fill: true,
                ),
          SizedBox(width: 10),
          Text(
            "存储池 ${pool.numId}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          if (pool.size != null)
            Text(
              //${Utils.formatSize(pool.size!.used!)} /
              "${Utils.formatSize(pool.size!.total!)}",
              style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
            ),
        ],
      ),
      children: [
        Text(
          "RAID类别",
          style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: pool.deviceType == "basic"
                    ? "Basic"
                    : pool.deviceType == "shr_without_disk_protect" || pool.deviceType == "shr"
                        ? "Synology Hybrid RAID (SHR) "
                        : pool.deviceType,
              ),
              if (pool.deviceType == "basic" || pool.deviceType == "shr_without_disk_protect")
                TextSpan(
                  text: "（无数据保护）",
                  style: TextStyle(color: AppTheme.of(context)?.errorColor),
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
        Divider(indent: 0, endIndent: 0, height: 20),
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
                  Text(
                    "${pool.scrubbingStatus == 'ready' ? '已就绪' : '${pool.scrubbingStatus}'}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            CupertinoButton(
              onPressed: () async {},
              padding: EdgeInsets.zero,
              child: Image.asset(
                "assets/icons/play_fill.png",
                width: 24,
              ),
            ),
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
        Divider(indent: 0, endIndent: 0, height: 20),
        Text(
          "硬盘信息",
          style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
        ),
        ...disks.map((disk) => DiskItemWidget(disk)).toList(),
      ],
    );
  }
}
