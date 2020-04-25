import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class StylesConstant {
  static const Color primaryColor = Color(0xFF7B71E9);
  static const Color accentColor = Colors.black;
  static const Color secondaryColor = Color(0xFFC1C1C1);
  static const Color bgColor = Color(0xFFF8F8F8);

  static const Color googleColor = Color(0xFF4285F4);
  static const Color facebookColor = Color(0xFF3A549F);

  static const List<Color> requestColors = [
    Colors.yellowAccent, // get
    Colors.cyan, // put
    Colors.greenAccent, // post
    Colors.lightBlueAccent, // patch
    Colors.redAccent, // delete
    Colors.white, // option
  ];

  static const double paddingSide = 20;

  static final ThemeData appTheme = ThemeData(
    textTheme: GoogleFonts.robotoMonoTextTheme(),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: StylesConstant.bgColor,
    brightness: Brightness.light,
    primaryColor: StylesConstant.primaryColor,
    accentColor: StylesConstant.accentColor,
  );
}
