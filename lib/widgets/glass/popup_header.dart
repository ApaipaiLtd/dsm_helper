import 'package:flutter/material.dart';

class PopupHeader extends StatelessWidget {
  final String? title;
  final double? titleSpacing;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? action;
  const PopupHeader({super.key, this.title, this.titleSpacing, this.leadingWidth, this.leading, this.action});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          SizedBox(
            width: leadingWidth ?? 50,
            child: leading,
          ),
          Expanded(
            child: Text(
              title ?? '',
              style: Theme.of(context).appBarTheme.titleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: leadingWidth ?? 50,
            child: action,
          )
        ],
      ),
    );
  }
}
