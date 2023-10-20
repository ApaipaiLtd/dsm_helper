import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  extensions: <ThemeExtension>[
    AppTheme(
      titleColor: Colors.black,
      placeholderColor: Colors.black54,
      primaryColor: Color(0xFF2A82E4),
      progressColor: Color(0xFFf4f4f4),
      successColor: Color(0xFF25B85F),
      warningColor: Color(0xFFFF8D1A),
      errorColor: Color(0xFFFF5733),
      cardColor: Colors.white,
    ),
  ],
  platform: TargetPlatform.iOS,
  primaryColor: Colors.black,
  disabledColor: Colors.black12,
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 15.0, color: Colors.black),
    bodySmall: TextStyle(fontSize: 12.0, color: Colors.black),
    // titleLarge: TextStyle(fontSize: 16, color: Colors.black),
    titleMedium: TextStyle(fontSize: 18.0, color: Colors.black),
  ),
  dialogBackgroundColor: Color(0xF000000),
  dividerTheme: DividerThemeData(
    color: Color(0xF000000),
    thickness: 1,
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
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xF000000)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xF000000)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xF000000)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff2A82E4)),
    ),
  ),
  buttonTheme: ButtonThemeData(),
  tabBarTheme: TabBarTheme(
    indicatorColor: Color(0xff2A82E4),
    indicatorSize: TabBarIndicatorSize.label,
    dividerColor: Colors.transparent,
    unselectedLabelColor: Colors.black,
    labelColor: Color(0xff2A82E4),
  ),
  cupertinoOverrideTheme: CupertinoThemeData(primaryColor: Color(0xff2A82E4), applyThemeToAll: true),
  splashFactory: NoSplash.splashFactory,
  highlightColor: Colors.transparent,
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
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
    elevation: 0,
    shadowColor: Colors.transparent,
  ),
  scaffoldBackgroundColor: Color(0xFFF4F4F4),
  useMaterial3: true,
);
