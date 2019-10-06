import 'package:flutter/material.dart';


final Map<String, ThemeData> appTheme = {
  "Dark": ThemeData(
    fontFamily: 'CircularStd',
    brightness: Brightness.dark,
    accentColor: Colors.black38,
    textTheme: TextTheme().apply(
      bodyColor: Colors.white70,
      displayColor: Colors.white70,  
    )
  ),

  "Light": ThemeData(
    fontFamily: 'CircularStd',
    brightness: Brightness.light,
    accentColor: Colors.white70,
    textTheme: TextTheme().apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    )
  ),  
};