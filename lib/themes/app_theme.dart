import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  static AppTheme of(BuildContext context) {
    return Theme.of(context).extension<AppTheme>();
  }

  final Color primaryColor;
  final Color placeholderColor;
  final Color titleColor;
  AppTheme({
    this.primaryColor,
    this.placeholderColor,
    this.titleColor,
  });

  @override
  ThemeExtension<AppTheme> copyWith({
    Color primaryColor,
    Color placeholderColor,
    Color titleColor,
  }) {
    return AppTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      placeholderColor: primaryColor ?? this.placeholderColor,
      titleColor: primaryColor ?? this.titleColor,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme> other, double t) {
    throw UnimplementedError();
  }
}
