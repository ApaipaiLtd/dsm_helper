import 'package:flutter/material.dart';

enum PartitionStatusEnum {
  normal(label: "正常", color: Color(0xFF25B85F)),
  background(label: "正在检查硬盘", color: Color(0xFFFF8D1A)),
  unknown(label: "未知", color: Colors.black54);

  final String label;
  final Color color;
  const PartitionStatusEnum({required this.label, required this.color});

  static PartitionStatusEnum fromValue(String value) {
    return PartitionStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => PartitionStatusEnum.unknown);
  }
}
