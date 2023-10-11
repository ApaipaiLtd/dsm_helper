import 'package:flutter/material.dart';

enum ShareLinkStatusEnum {
  valid(label: "有效", value: "valid", color: Color(0xFF25B85F)),
  expired(label: "过期", value: "valid", color: Color(0xFFFF5733)),
  inactive(label: "未生效", value: "inactive", color: Colors.black54),
  unknown(label: "未知", value: "unknown", color: Colors.black54),
  broken(label: "坏链", value: "broken", color: Color(0xFFFF5733));

  final String label;
  final String value;
  final Color color;
  const ShareLinkStatusEnum({required this.label, required this.value, required this.color});

  static ShareLinkStatusEnum fromValue(String value) {
    return ShareLinkStatusEnum.values.firstWhere((element) => element.value == value, orElse: () => ShareLinkStatusEnum.unknown);
  }
}
