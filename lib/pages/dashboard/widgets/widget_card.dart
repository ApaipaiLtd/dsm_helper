import 'package:flutter/material.dart';

class WidgetCard extends StatelessWidget {
  final Widget? icon;

  final String? title;

  final Widget? body;

  final Function()? onTap;

  const WidgetCard({this.icon, this.title, this.body, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            if (icon != null || title != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    if (icon != null) icon!,
                  ],
                ),
              ),
            if (body != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: body,
              ),
          ],
        ),
      ),
    );
  }
}
