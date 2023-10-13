import 'package:flutter/material.dart';

enum FirewallStatusEnum {
  allow(label: "允许", color: Color(0xFF25B85F)),
  deny(label: "拒绝", color: Color(0xFFFF5733)),
  unknown(label: "-", color: Colors.black54);

  const FirewallStatusEnum({required this.label, required this.color});
  final String label;
  final Color color;

  static FirewallStatusEnum fromValue(String value) {
    return FirewallStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => FirewallStatusEnum.unknown);
  }
}
