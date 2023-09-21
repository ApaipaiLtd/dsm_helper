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
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            if (icon != null && title != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    if (icon != null) ...[
                      icon!,
                      SizedBox(
                        width: 10,
                      ),
                    ],
                    if (title != null)
                      Text(
                        title!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
              ),
            if (body != null) ...[
              SizedBox(
                height: 10,
              ),
              body!,
            ],
          ],
        ),
      ),
    );
  }
}
