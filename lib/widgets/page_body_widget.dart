import 'package:flutter/material.dart';

class PageBodyWidget extends StatelessWidget {
  final Widget? body;
  const PageBodyWidget({this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -137,
          top: -153,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 450,
                  color: Color(0xFFDFDFFB),
                ),
              ],
            ),
            width: 392,
            height: 392,
          ),
        ),
        Positioned(
          right: -257,
          top: -153,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 450,
                  color: Color(0xFFE9F5FF),
                ),
              ],
            ),
            width: 392,
            height: 392,
          ),
        ),
        if (body != null) body!,
      ],
    );
  }
}
