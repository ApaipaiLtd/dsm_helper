import 'package:flutter/material.dart';

enum DockerStatusEnum {
  running(label: "正常", color: Colors.green),
  stopped(label: "正在检查硬盘", color: Colors.lightBlueAccent),
  unknown(label: "未知", color: Colors.red);

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
