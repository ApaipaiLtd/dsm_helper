import 'package:flutter/material.dart';

class GlassScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final List<Widget>? persistentFooterButtons;

  final Widget? floatingActionButton;
  const GlassScaffold({
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.persistentFooterButtons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      persistentFooterButtons: persistentFooterButtons,
      persistentFooterAlignment: AlignmentDirectional.center,
      body: Stack(
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
      ),
    );
  }
}
