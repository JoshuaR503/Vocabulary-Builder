import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';

class TextStyles {
  static const TextStyle titleStyle = const TextStyle(
    fontSize: 24.5,
    color: Colors.white,
    fontWeight: FontWeight.bold
  );

  static const TextStyle definitionStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w100,
    color: AppFontColors.secondaryText
  );
}