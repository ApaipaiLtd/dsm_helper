import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/pages/dashboard/enums/volume_status_enum.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/line_progress_bar.dart';
import 'package:flutter/material.dart';

class VolumeItemWidget extends StatelessWidget {
  final Volumes volume;
  final bool isLast;
  const VolumeItemWidget(this.volume, {this.isLast = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            volume.statusEnum != VolumeStatusEnum.unknown
                ? Label(
                    volume.statusEnum.label,
                    volume.statusEnum.color,
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
        LineProgressBar(value: volume.size!.usedPercent),
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
    );
  }
}
