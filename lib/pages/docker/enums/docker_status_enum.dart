import 'package:flutter/material.dart';

enum DockerStatusEnum {
  running(label: "运行中", color: Color(0xFF25B85F)),
  stopped(label: "已停止", color: Colors.black54),
  unknown(label: "未知", color: Colors.orangeAccent);

  final String label;
  final Color color;

  const DockerStatusEnum({
    required this.label,
    required this.color,
  });

  static DockerStatusEnum fromValue(String value) {
    return DockerStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => DockerStatusEnum.unknown);
  }
}
