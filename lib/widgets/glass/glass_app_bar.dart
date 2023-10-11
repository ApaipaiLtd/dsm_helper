import 'dart:ui';

import 'package:flutter/material.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  GlassAppBar({
    this.toolbarHeight,
    this.title,
    this.automaticallyImplyLeading = true,
    this.titleSpacing,
    this.leadingWidth,
    this.leading,
    this.bottom,
    this.actions,
    super.key,
  }) : preferredSize = _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);

  final Widget? title;
  final double? toolbarHeight;
  final double? leadingWidth;

  final double? titleSpacing;

  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: Colors.transparent,
      titleSpacing: titleSpacing,
      notificationPredicate: (_) {
        return false;
      },
      actions: actions,
      bottom: bottom,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  @override
  final Size preferredSize;
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight) : super.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
