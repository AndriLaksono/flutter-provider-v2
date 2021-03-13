import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static final normalTheme = ThemeData(
      primarySwatch: Colors.pink,
      accentColor: Colors.amber,
      fontFamily: 'Lato',
      visualDensity: VisualDensity.adaptivePlatformDensity);
}
