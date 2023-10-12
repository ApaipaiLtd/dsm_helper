import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/material.dart';

class ControlPanelItemWidget extends StatelessWidget {
  final String title;
  final double width;
  final String icon;
  final Function()? onTap;
  const ControlPanelItemWidget({required this.title, required this.icon, required this.width, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: width,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/control_panel/${Utils.version}/$icon.png",
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
