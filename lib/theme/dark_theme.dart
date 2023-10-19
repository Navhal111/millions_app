import 'package:flutter/material.dart';

ThemeData dark = ThemeData.dark().copyWith(
  // fontFamily: 'Poppins',
  primaryColor: Color(0xFF000000),
  secondaryHeaderColor: Color(0xFF171717).withOpacity(0.7),
  canvasColor:Color(0xff393433) ,

  disabledColor: Color(0xff8b8b8b),
  backgroundColor: Color(0xFFB216D7),
  errorColor: Color(0xFFdd3135),
  hintColor: Color(0xFFffffff),
  cardColor: Color(0xFFE2A21D),
  colorScheme: ColorScheme.light(
      primary: Color(0xFFE2A21D), secondary: Color(0xFFE2A21D)),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: Color(0xFFE2A21D))),
);
