import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  extensions: [
    AppTheme(primaryColor: Colors.red, placeholderColor: Color(0xff7E7E7E)),
  ],
  primaryColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(color: Color(0xff333333), fontSize: 16),
    iconTheme: IconThemeData(
      color: Color(0xff7E7E7E),
    ),
    centerTitle: true,
  ),
  buttonTheme: ButtonThemeData(padding: EdgeInsets.symmetric(horizontal: 0)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionHandleColor: Colors.black,
    selectionColor: Colors.black38,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.white,
    shadowColor: Colors.transparent,
    elevation: 0,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
  ),
  // iconTheme: IconThemeData(
  //   color: Colors.black,
  // ),
  dialogBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), gapPadding: 0, borderSide: BorderSide(color: Colors.black26)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), gapPadding: 0, borderSide: BorderSide(color: Colors.black26)),
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), gapPadding: 0, borderSide: BorderSide(color: Colors.black26)),
    outlineBorder: BorderSide(color: Colors.black26),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(50)), gapPadding: 0),
    iconColor: Colors.black,
    suffixIconColor: Color(0xff7E7E7E),
  ),
  scaffoldBackgroundColor: Color(0xFFF2F2F7),
  useMaterial3: true,
);
