import 'package:flutter/material.dart';

enum DiskOverviewStatusEnum {
  normal(label: "正常", color: Color(0xFF25B85F)),
  unknown(label: "未知", color: Colors.black54);

  const DiskOverviewStatusEnum({required this.label, required this.color});
  final String label;
  final Color color;

  static DiskOverviewStatusEnum fromValue(String value) {
    return DiskOverviewStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => DiskOverviewStatusEnum.unknown);
  }
}
