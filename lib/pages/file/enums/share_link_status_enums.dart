import 'package:flutter/material.dart';

enum ShareLinkStatusEnum {
  valid(label: "有效", color: Color(0xFF25B85F)),
  expired(label: "过期", color: Color(0xFFFF5733)),
  inactive(label: "未生效", color: Colors.black54),
  unknown(label: "未知", color: Colors.black54),
  broken(label: "坏链", color: Color(0xFFFF5733));

  final String label;
  final Color color;
  const ShareLinkStatusEnum({required this.label, required this.color});

  static ShareLinkStatusEnum fromValue(String value) {
    return ShareLinkStatusEnum.values.firstWhere((element) => element.name == value, orElse: () => ShareLinkStatusEnum.unknown);
  }
}
