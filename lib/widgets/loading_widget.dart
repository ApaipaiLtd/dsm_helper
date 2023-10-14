import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double size;
  const LoadingWidget({this.color, this.size = 14, super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.fourRotatingDots(
      color: color ?? Theme.of(context).primaryColor,
      size: size,
    );
  }
}
