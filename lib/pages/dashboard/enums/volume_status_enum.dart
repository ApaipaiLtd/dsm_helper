import 'package:flutter/material.dart';

enum VolumeStatusEnum {
  normal(label: "正常", color: Colors.green),
  background(label: "正在检查硬盘", color: Colors.lightBlueAccent),
  attention(label: "注意", color: Colors.orangeAccent),
  unknown(label: "未知", color: Colors.red);

  final String label;
  final Color color;

  const VolumeStatusEnum({
    required this.label,
    required this.color,
  });

  static VolumeStatusEnum fromValue(String value) {
    return VolumeStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => VolumeStatusEnum.unknown);
  }
}
