import 'package:flutter/material.dart';

enum DockerLogLevelEnum {
  info(label: "信息", color: Color(0xF000000)),
  warning(label: "警告", color: Colors.orangeAccent),
  err(label: "错误", color: Color(0xFFFF5733)),
  unknown(label: "未知", color: Colors.black54);

  final String label;
  final Color color;

  const DockerLogLevelEnum({
    required this.label,
    required this.color,
  });

  static DockerLogLevelEnum fromValue(String value) {
    return DockerLogLevelEnum.values.firstWhere((element) => element.name == value, orElse: () => DockerLogLevelEnum.unknown);
  }
}
