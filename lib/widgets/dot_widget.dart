import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final Color? color;
  final double? size;
  const DotWidget({this.color, this.size = 10, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
