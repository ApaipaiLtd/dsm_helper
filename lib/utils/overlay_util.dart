import 'package:flutter/material.dart';

class OverlayUtil {
  static BuildContext? context;
  static OverlayEntry? overlayEntry;
  static void init(BuildContext context) {
    OverlayUtil.context = context;
  }

  static show(Widget widget) {
    hide();
    if (context != null) {
      overlayEntry = OverlayEntry(
        builder: (context) => widget,
      );

      // 获取OverlayState并插入OverlayEntry
      Overlay.of(context!).insert(overlayEntry!);
    }
  }

  static hide() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }
}
