import 'package:flutter/material.dart';

enum GuestTypeEnum {
  healthy(label: "有效", color: Color(0xFF25B85F)),
  warning(label: "warning", color: Color(0xFFFF8D1A)),
  unknown(label: "未知", color: Colors.black54);

  final String label;
  final Color color;
  const GuestTypeEnum({required this.label, required this.color});

  static GuestTypeEnum fromValue(String value) {
    return GuestTypeEnum.values.firstWhere((element) => element.name == value, orElse: () => GuestTypeEnum.unknown);
  }
}
