import 'package:dsm_helper/util/function.dart';
import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';

typedef OnPressed = Function();

class TerminalButton extends StatelessWidget {
  final OnPressed onPressed;
  final Widget child;
  final EdgeInsets padding;
  const TerminalButton({this.onPressed, this.child, this.padding, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Util.vibrate(FeedbackType.light);
        onPressed();
      },
      child: Container(
        width: 40,
        height: 30,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
