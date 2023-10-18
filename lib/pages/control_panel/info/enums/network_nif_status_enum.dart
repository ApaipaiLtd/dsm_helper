import 'package:flutter/material.dart';

enum NetworkStatusEnum {
  connected(label: "已联机", color: Color(0xFF25B85F)),
  disconnected(label: "尚未联机", color: Color(0xFFFF5733)),
  unknown(label: "未知", color: Colors.black54);

  const NetworkStatusEnum({required this.label, required this.color});
  final String label;
  final Color color;

  static NetworkStatusEnum fromValue(String value) {
    return NetworkStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => NetworkStatusEnum.unknown);
  }
}
