import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  extensions: <ThemeExtension>[
    AppTheme(
      titleColor: Color(0xff121212),
      placeholderColor: Color(0xffa9a9a9),
      primaryColor: Color(0xff333333),
      progressColor: Color(0xfff4f4f4),
    ),
  ],
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 12.0,
      color: Color(0xff121212),
    ),
    bodyText2: TextStyle(
      fontSize: 15.0,
      color: Color(0xff121212),
    ),
    subtitle1: TextStyle(
      fontSize: 18.0,
      color: Color(0xff121212),
    ),
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
    color: Color(0xFFF4F4F4),
    iconTheme: IconThemeData(color: Color(0xff121212)),
    actionsIconTheme: IconThemeData(color: Color(0xff121212)),
    titleTextStyle: TextStyle(fontSize: 20.0, color: Color(0xff121212)),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  backgroundColor: Color(0xFFF4F4F4),
  scaffoldBackgroundColor: Color(0xFFF4F4F4),
);
