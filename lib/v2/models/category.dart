import 'package:flutter/material.dart';

class WordCategory {
  const WordCategory({
    @required this.name,
    @required this.color,
    @required this.accentColor,
    
    @required this.routeName,
    this.isSpecial = false,
  });

  final Color color;
  final Color accentColor;

  final String name;
  final String routeName;
  final bool isSpecial;
}
