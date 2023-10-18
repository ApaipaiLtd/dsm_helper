import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/storage_manager/enums/disk_smart_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/enums/disk_status_enum.dart';
import 'package:dsm_helper/pages/storage_manager/widgets/disk_item_widget.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/expansion_container.dart';
import 'package:flutter/material.dart';

class DiskCardItemWidget extends StatelessWidget {
  final Disks disk;
  final StoragePools? usedByPool;
  final Volumes? usedBySsdCache;
  const DiskCardItemWidget(this.disk, {this.usedByPool, this.usedBySsdCache, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.of(context)?.cardColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: ExpansionContainer(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: EdgeInsets.symmetric(vertical: 10),
        title: DiskItemWidget(disk, isLast: true),
        children: [
          Text(
            "位置",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${disk.container?.str}",
            style: TextStyle(fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "配置用途",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          if (usedByPool != null) Text("存储池 ${usedByPool!.numId}") else if (usedBySsdCache != null) Text("${usedBySsdCache!.displayName}") else Text("-"),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "分配状态",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            disk.statusEnum != DiskStatusEnum.unknown ? disk.statusEnum.label : disk.status!,
            style: TextStyle(color: disk.statusEnum.color, fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "健康状态",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            disk.smartStatusEnum != DiskSmartStatusEnum.unknown ? disk.smartStatusEnum.label : disk.smartStatus!,
            style: TextStyle(color: disk.smartStatusEnum.color, fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "温度",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${disk.temp ?? '-'}℃",
            style: TextStyle(fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "序列号",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${disk.serial ?? '-'}",
            style: TextStyle(fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "固件版本",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${disk.firm ?? '-'}",
            style: TextStyle(fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "4K原生硬盘",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${disk.is4Kn == true ? '是' : '否'}",
            style: TextStyle(fontSize: 16),
          ),
          //   WidgetCard(
          //     title: "信息",
          //     boxDecoration: BoxDecoration(
          //       color: Theme.of(context).scaffoldBackgroundColor,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     body: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "RAID类别",
          //           style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          //         ),
          //         Text.rich(
          //           TextSpan(
          //             children: [
          //               TextSpan(
          //                 text: pool.deviceType == "basic"
          //                     ? "Basic"
          //                     : pool.deviceType == "shr_without_disk_protect" || pool.deviceType == "shr"
          //                         ? "Synology Hybrid RAID (SHR) "
          //                         : pool.deviceType,
          //               ),
          //               if (pool.deviceType == "basic" || pool.deviceType == "shr_without_disk_protect")
          //                 TextSpan(
          //                   text: "（无数据保护）",
          //                   style: TextStyle(color: AppTheme.of(context)?.errorColor),
          //                 ),
          //             ],
          //           ),
          //           style: TextStyle(fontSize: 16),
          //         ),
          //         Divider(indent: 0, endIndent: 0, height: 20),
          //         Text(
          //           "支持多个存储空间",
          //           style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          //         ),
          //         Text(
          //           "${pool.raidType == 'single' ? '否' : '是'}",
          //           style: TextStyle(fontSize: 16),
          //         ),
          //       ],
          //     ),
          //   ),
          //   WidgetCard(
          //     title: "数据清理",
          //     boxDecoration: BoxDecoration(
          //       color: Theme.of(context).scaffoldBackgroundColor,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     body: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Row(
          //           children: [
          //             Expanded(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "数据清理",
          //                     style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          //                   ),
          //                   Text(
          //                     "${pool.scrubbingStatusEnum != StoragePoolScrubbingStatusEnum.unknown ? pool.scrubbingStatusEnum.label : '${pool.scrubbingStatus}'}",
          //                     style: TextStyle(fontSize: 16),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             if (pool.scrubbingStatusEnum == StoragePoolScrubbingStatusEnum.ready)
          //               CupertinoButton(
          //                 onPressed: () async {},
          //                 padding: EdgeInsets.zero,
          //                 child: Image.asset(
          //                   "assets/icons/play_circle_fill.png",
          //                   width: 24,
          //                 ),
          //               )
          //             else ...[
          //               CupertinoButton(
          //                 onPressed: () async {},
          //                 padding: EdgeInsets.zero,
          //                 child: Image.asset(
          //                   "assets/icons/pause_circle_fill.png",
          //                   width: 24,
          //                 ),
          //               ),
          //               CupertinoButton(
          //                 onPressed: () async {},
          //                 padding: EdgeInsets.zero,
          //                 child: Image.asset(
          //                   "assets/icons/remove_circle_fill.png",
          //                   width: 24,
          //                 ),
          //               )
          //             ],
          //           ],
          //         ),
          //         Divider(indent: 0, endIndent: 0, height: 20),
          //         Text(
          //           "完成时间",
          //           style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          //         ),
          //         Text(
          //           "${pool.lastDoneTime != null && pool.lastDoneTime! > 0 ? DateTime.fromMillisecondsSinceEpoch(pool.lastDoneTime!.toInt() * 1000).format("Y-m-d H:i") : "从未执行"}",
          //           style: TextStyle(fontSize: 16),
          //         ),
          //       ],
          //     ),
          //   ),
          //   WidgetCard(
          //     title: "硬盘信息",
          //     boxDecoration: BoxDecoration(
          //       color: Theme.of(context).scaffoldBackgroundColor,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     body: Column(
          //       children: disks.map((disk) => DiskItemWidget(disk)).toList(),
          //     ),
          //   ),
          //   WidgetCard(
          //     boxDecoration: BoxDecoration(
          //       color: Theme.of(context).scaffoldBackgroundColor,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     title: "存储分配",
          //     body: Column(
          //       children: volumes.map((volume) => VolumeItemWidget(volume, showFileSystem: true)).toList(),
          //     ),
          //   ),
          //   SizedBox(
          //     height: 10,
          //   ),
        ],
      ),
    );
  }
}
