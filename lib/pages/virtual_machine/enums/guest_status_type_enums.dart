import 'package:flutter/material.dart';

enum GuestStatusTypeEnum {
  healthy(label: "有效", color: Color(0xFF25B85F)),
  warning(label: "警告", color: Color(0xFFFF8D1A)),
  unknown(label: "未知", color: Colors.black54);

  final String label;
  final Color color;
  const GuestStatusTypeEnum({required this.label, required this.color});

  static GuestStatusTypeEnum fromValue(String value) {
    return GuestStatusTypeEnum.values.firstWhere((element) => element.name == value, orElse: () => GuestStatusTypeEnum.unknown);
  }
}
