import 'package:flutter/material.dart';

enum DiskSmartStatusEnum {
  normal(label: "正常", color: Color(0xFF25B85F)),
  system_crashed(label: "无法访问系统分区", color: Color(0xFFFF5733)),
  critical(label: "严重", color: Color(0xFFFF5733)),
  unknown(label: "未知", color: Colors.black54);

  const DiskSmartStatusEnum({required this.label, required this.color});
  final String label;
  final Color color;

  static DiskSmartStatusEnum fromValue(String value) {
    return DiskSmartStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => DiskSmartStatusEnum.unknown);
  }
}
