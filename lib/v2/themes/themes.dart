import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark
}

final Map<AppTheme, ThemeData> appTheme = {
  AppTheme.Dark: ThemeData(
    fontFamily: 'CircularStd',
    brightness: Brightness.dark,
    accentColor: Colors.black38,
    textTheme: TextTheme().apply(
      bodyColor: Colors.white70,
      displayColor: Colors.white70,  
    )
  ),

  AppTheme.Light: ThemeData(
    fontFamily: 'CircularStd',
    brightness: Brightness.light,
    accentColor: Colors.white,
    textTheme: TextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    )
  ),  
};