import 'package:flutter/material.dart';

enum UserExpiredEnum {
  normal(label: "正常", color: Color(0xFF25B85F)),
  now(label: "停用", color: Color(0xFFFF5733)),
  date(label: "到期于", color: Colors.black54),
  unknown(label: "-", color: Colors.black54);

  const UserExpiredEnum({required this.label, required this.color});
  final String label;
  final Color color;

  static UserExpiredEnum fromValue(String? value) {
    if (value != null) {
      return UserExpiredEnum.unknown;
    } else {
      return UserExpiredEnum.values.firstWhere((element) => element.name == value, orElse: () => UserExpiredEnum.date);
    }
  }
}
