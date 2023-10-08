import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  static AppTheme? of(BuildContext context) {
    return Theme.of(context).extension<AppTheme>();
  }

  final Color? primaryColor;
  final Color? placeholderColor;
  final Color? titleColor;
  final Color? progressColor;
  final Color? successColor;
  final Color? warningColor;
  final Color? errorColor;
  AppTheme({
    this.primaryColor,
    this.placeholderColor,
    this.titleColor,
    this.progressColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
  });

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? primaryColor,
    Color? placeholderColor,
    Color? titleColor,
    Color? progressColor,
    Color? errorColor,
  }) {
    return AppTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      titleColor: titleColor ?? this.titleColor,
      progressColor: progressColor ?? this.progressColor,
      successColor: progressColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme> other, double t) {
    return this;
  }
}
