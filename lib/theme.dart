import 'package:flutter/material.dart';

ThemeData getThemeData() {
  return ThemeData(
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: const Color(0xFFFBFDFF),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Color(0xff011562),
      ),
    ),
  );
}
