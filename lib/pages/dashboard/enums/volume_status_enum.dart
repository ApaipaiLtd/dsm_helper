import 'package:flutter/material.dart';

enum VolumeStatusEnum {
  normal(label: "良好", color: Color(0xFF25B85F)),
  background(label: "正在检查硬盘", color: Colors.lightBlueAccent),
  attention(label: "警告", color: Colors.orangeAccent),
  unknown(label: "未知", color: Color(0xFFFF5733));

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
