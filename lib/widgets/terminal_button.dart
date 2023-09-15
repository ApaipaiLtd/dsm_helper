import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

typedef OnPressed = Function();

class TerminalButton extends StatelessWidget {
  final OnPressed? onPressed;
  final Widget? child;
  final EdgeInsets? padding;
  final bool active;
  const TerminalButton({this.onPressed, this.child, this.padding, this.active = false, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.vibrate(FeedbackType.light);
        onPressed?.call();
      },
      child: Container(
        color: active ? Colors.blue.withOpacity(0.4) : null,
        width: 40,
        height: 30,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
