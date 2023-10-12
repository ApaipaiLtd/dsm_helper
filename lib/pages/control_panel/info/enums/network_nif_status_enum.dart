import 'package:flutter/material.dart';

enum NetworkNifStatusEnum {
  connected(label: "已联机", color: Color(0xFF25B85F)),
  system_crashed(label: "无法访问系统分区", color: Color(0xFFFF5733)),
  unknown(label: "未知", color: Colors.black54);

  const NetworkNifStatusEnum({required this.label, required this.color});
  final String label;
  final Color color;

  static NetworkNifStatusEnum fromValue(String value) {
    return NetworkNifStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => NetworkNifStatusEnum.unknown);
  }
}
