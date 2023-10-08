import 'dart:math';

import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/material.dart';

class LineProgressBar extends StatelessWidget {
  final num value;
  final Color? backgroundColor;
  const LineProgressBar({required this.value, this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: value == 0 ? 0 : max(1, value.toInt()),
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: value > 80 ? AppTheme.of(context)?.errorColor : AppTheme.of(context)?.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        if (value > 0) SizedBox(width: 3),
        Expanded(
          flex: value == 0 ? 100 : max(1, (100 - value).toInt()),
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppTheme.of(context)?.successColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}
