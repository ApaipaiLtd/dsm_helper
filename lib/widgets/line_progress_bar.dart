import 'dart:math';

import 'package:flutter/material.dart';

class LineProgressBar extends StatelessWidget {
  final double value;
  const LineProgressBar({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: max(1, value.toInt()),
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: value > 80 ? Colors.red : Colors.blueAccent,
              borderRadius: BorderRadius.circular(2),
            ),
            constraints: BoxConstraints(
              minWidth: 10,
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Expanded(
          flex: max(1, (100 - value).toInt()),
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(2),
            ),
            constraints: BoxConstraints(
              minWidth: 10,
            ),
          ),
        ),
      ],
    );
  }
}
