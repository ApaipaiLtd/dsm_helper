import 'package:flutter/material.dart';

enum VolumeStatusEnum {
  normal(label: "良好", color: Color(0xFF25B85F)),
  background(label: "正在检查硬盘", color: Colors.black54),
  attention(label: "警告", color: Color(0xFFFF8D1A)),
  has_unverified_disk(label: "包含未验证的硬盘", color: Color(0xFFFF8D1A)),
  background_scrubbing(label: "正在运行数据清理", color: Color(0xFF2A82E4)),
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
