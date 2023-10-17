import 'package:flutter/material.dart';

enum StoragePoolScrubbingStatusEnum {
  ready(label: "已就绪", color: Color(0xFF25B85F)),
  manual_running(label: "手动运行", color: Color(0xFF2A82E4)),
  schedule_done(label: "计划完成", color: Color(0xFF25B85F)),
  paused(label: "已暂停", color: Color(0xFFFF8D1A)),
  unknown(label: "未知", color: Colors.black54);

  const StoragePoolScrubbingStatusEnum({required this.label, required this.color});
  final String label;
  final Color color;

  static StoragePoolScrubbingStatusEnum fromValue(String value) {
    return StoragePoolScrubbingStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => StoragePoolScrubbingStatusEnum.unknown);
  }
}
