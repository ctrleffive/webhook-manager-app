import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class StylesConstant {
  static const Color primaryColor = Color(0xFF124893);
  static const Color accentColor = Color(0xFF0076CA);

  static const Color textColor = Colors.black87;

  static const Color googleColor = Color(0xFF4285F4);
  static const Color facebookColor = Color(0xFF3A549F);

  static const double paddingSide = 20;

  static final ThemeData appTheme = ThemeData(
    textTheme: GoogleFonts.ubuntuTextTheme(),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: StylesConstant.textColor,
      ),
    ),
    brightness: Brightness.light,
    primaryColor: StylesConstant.primaryColor,
    accentColor: StylesConstant.accentColor,
  );
}
