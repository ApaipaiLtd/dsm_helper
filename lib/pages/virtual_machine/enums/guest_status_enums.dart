import 'package:flutter/material.dart';

enum GuestStatusEnum {
  running(label: "运行中", color: Color(0xFF25B85F)),
  shutdown(label: "已关机", color: Colors.black54),
  shutting_down(label: "正在关机", color: Color(0xFFFF8D1A)),
  saved(label: "已暂停", color: Colors.black54),
  none(label: "无", color: Color(0xFFFF8D1A)),
  unknown(label: "未知", color: Colors.black54);

  final String label;
  final Color color;
  const GuestStatusEnum({required this.label, required this.color});

  static GuestStatusEnum fromValue(String value) {
    return GuestStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => GuestStatusEnum.unknown);
  }
}
