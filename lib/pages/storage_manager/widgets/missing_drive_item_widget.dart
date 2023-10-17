import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:flutter/material.dart';

class MissingDriveItemWidget extends StatelessWidget {
  final MissingDrives drive;
  final bool isLast;
  const MissingDriveItemWidget(this.drive, {this.isLast = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${drive.name}",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            SizedBox(width: 5),
            Label(
              "${drive.mediumType}",
              AppTheme.of(context)?.primaryColor ?? Colors.blue,
            ),
            SizedBox(width: 5),
            if (drive.sizeTotal != null)
              Label(
                "${Utils.formatSize(drive.sizeTotal!)}",
                Color(0xFF00BAAD),
              ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            if (drive.vendor != null && drive.vendor != '')
              Text(
                "${drive.vendor!.trim()}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 12),
              ),
            if (drive.model != null && drive.model != '')
              Text(
                "${drive.model}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 12),
              ),
            if (drive.serial != null && drive.serial != '')
              Text(
                "序列号：${drive.serial}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 12),
              ),
          ],
        ),
        if (!isLast) Divider(height: 10),
      ],
    );
  }
}
