import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/storage_manager/enums/disk_status_enum.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:flutter/material.dart';

class DiskItemWidget extends StatelessWidget {
  final Disks disk;
  final bool showStatus;
  final bool isLast;
  const DiskItemWidget(this.disk, {this.showStatus = false, this.isLast = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${disk.name}",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            SizedBox(width: 5),
            Label(
              "${disk.isSsd == true ? 'SSD' : 'HDD'}",
              AppTheme.of(context)?.primaryColor ?? Colors.blue,
              fill: disk.isSsd == true,
            ),
            SizedBox(width: 5),
            Label(
              "${disk.temp ?? '-'}℃",
              disk.temp != null && disk.temp! < 80 ? AppTheme.of(context)!.successColor! : AppTheme.of(context)!.errorColor!,
              fill: true,
            ),
            SizedBox(width: 5),
            Label(
              "${disk.sizeTotal != null ? Utils.formatSize(int.parse(disk.sizeTotal!)) : '-'}",
              Color(0xFF00BAAD),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            if (!showStatus) ...[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: disk.statusEnum.color,
                  shape: BoxShape.circle,
                ),
                margin: EdgeInsets.only(right: 3),
              ),
              Text(
                disk.statusEnum != DiskStatusEnum.unknown ? disk.statusEnum.label : disk.status!,
                style: TextStyle(color: disk.statusEnum.color, fontSize: 12),
              ),
              SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                "${disk.vendor?.trim()} ${disk.model}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 12),
              ),
            ),
          ],
        ),
        if (showStatus) ...[
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "分配状态",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${disk.statusEnum.label}",
                      style: TextStyle(fontSize: 14, color: disk.statusEnum.color),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "健康状态",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${disk.smartStatusEnum.label}",
                      style: TextStyle(fontSize: 14, color: disk.smartStatusEnum.color),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        if (!isLast) Divider(height: 10),
      ],
    );
  }
}
