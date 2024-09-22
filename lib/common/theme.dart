import 'package:flutter/material.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.blueAccent,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Corben',
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Corben',
      fontWeight: FontWeight.w600,
      fontSize: 19,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Corben',
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.black,
    ),
  ),
);
