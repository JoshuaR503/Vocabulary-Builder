import 'package:flutter/material.dart';

class WordCategory {
  const WordCategory({
    @required this.name,
    @required this.color,
    @required this.accentColor,

    this.categoryName,
    this.isSpecial = false,
  });

  final Color color;
  final Color accentColor;

  final String name;
  final String categoryName;
  final bool isSpecial;
}
