import 'package:flutter/material.dart';

class PopupMenuItem extends StatelessWidget {
  final String title;
  final String? iconPath;
  final EdgeInsets? padding;
  final Function()? onTap;
  const PopupMenuItem({required this.title, this.iconPath, this.padding, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            if (iconPath != null) ...[
              Image.asset(
                iconPath!,
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
            ],
            Text("$title"),
          ],
        ),
      ),
    );
  }
}
