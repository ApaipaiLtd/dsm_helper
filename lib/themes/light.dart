import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  extensions: <ThemeExtension>[
    AppTheme(
      titleColor: Color(0xff121212),
      placeholderColor: Colors.black54,
      primaryColor: Color(0xff2A82E4),
      progressColor: Color(0xfff4f4f4),
    ),
  ],
  primaryColor: Colors.black,
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 15.0, color: Colors.black),
    bodySmall: TextStyle(fontSize: 12.0, color: Colors.black),
    titleMedium: TextStyle(fontSize: 18.0, color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 16.0,
      color: Colors.grey,
    ),
    labelStyle: TextStyle(
      fontSize: 16.0,
      color: Colors.grey,
    ),
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    // color: Color(0xFFF4F4F4),
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(fontSize: 18.0, color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    background: Color(0xFFF4F4F4),
  ),
  scaffoldBackgroundColor: Color(0xFFF4F4F4),
  useMaterial3: true,
);
