import 'package:flutter/material.dart';

enum DeviceStatusEnum {
  normal(label: "正常", color: Color(0xFF25B85F)),
  unknown(label: "未知", color: Colors.black54);

  final String label;
  final Color color;
  const DeviceStatusEnum({required this.label, required this.color});

  static DeviceStatusEnum fromValue(String value) {
    return DeviceStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => DeviceStatusEnum.unknown);
  }
}
