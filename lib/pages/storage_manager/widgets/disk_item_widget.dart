import 'package:dsm_helper/models/Syno/Storage/Cgi/Storage.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/material.dart';

class DiskItemWidget extends StatelessWidget {
  final Disks disk;
  const DiskItemWidget(this.disk, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "硬盘 ${disk.numId} (${disk.isSsd == true ? 'SSD' : 'HDD'})",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "大小： ${disk.sizeTotal != null ? Utils.formatSize(int.parse(disk.sizeTotal!)) : '-'}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "分配状态： ${disk.statusEnum.label}",
            style: TextStyle(fontSize: 16, color: disk.statusEnum.color, fontWeight: FontWeight.bold),
          ),
          Text(
            "健康状态： ${disk.smartStatusEnum.label}",
            style: TextStyle(fontSize: 16, color: disk.smartStatusEnum.color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
