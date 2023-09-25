import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String? text;
  const EmptyWidget({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/empty.png"),
          Text(
            text ?? "暂无数据",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
          ),
        ],
      ),
    );
  }
}
