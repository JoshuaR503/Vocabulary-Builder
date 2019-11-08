import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';

class TextStyles {
  static const TextStyle titleStyle = const TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle definitionStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: AppFontColors.secondaryText
  );

  static const TextStyle commonTitleStyle = const TextStyle(
    fontSize: 25.5,
    fontWeight: FontWeight.bold,
    color: Colors.white
  );

  static const TextStyle commonSubtitleStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Heebo',
    color: Colors.white70
  );
}