import 'dart:ui';

import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showGlassModalPopup<T>(
  BuildContext context, {
  double? height,
  List<Widget>? buttons,
  Widget? content,
}) async {
  return await showCupertinoModalPopup<T>(
      context: context,
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              minHeight: 100,
              maxHeight: context.height * 0.8,
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  content != null
                      ? Expanded(
                          child: content,
                        )
                      : Spacer(),
                  if (buttons != null && buttons.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: buttons.length > 1
                          ? Row(
                              children: buttons,
                            )
                          : buttons.first,
                    ),
                ],
              ),
            ),
          ),
        );
      });
}
