import 'dart:ui';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  extensions: <ThemeExtension>[
    AppTheme(
      titleColor: Color(0xffa6a6a6),
      placeholderColor: Color(0xffa6a6a6),
      primaryColor: Color(0xff121212),
      progressColor: Color(0xffd3d3d3),
    ),
  ],
  backgroundColor: Color(0xff121212),
  scaffoldBackgroundColor: Color(0xff121212),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 12.0,
      color: Color(0xffa6a6a6),
    ),
    bodyText2: TextStyle(
      fontSize: 15.0,
      color: Color(0xffa6a6a6),
    ),
    subtitle1: TextStyle(
      fontSize: 18.0,
      color: Color(0xffa6a6a6),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 16.0,
      color: Color(0xff808080),
    ),
    helperStyle: TextStyle(
      fontSize: 16.0,
      color: Color(0xff808080),
    ),
    labelStyle: TextStyle(
      fontSize: 16.0,
      color: Color(0xff808080),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xffa6a6a6)),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    color: Color(0xff121212),
    iconTheme: IconThemeData(color: Color(0xffa6a6a6)),
    actionsIconTheme: IconThemeData(color: Color(0xffa6a6a6)),
    titleTextStyle: TextStyle(fontSize: 20.0, color: Color(0xffa6a6a6)),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  colorScheme: ColorScheme.dark(
    secondary: Color(0xff888888),
  ),
);
