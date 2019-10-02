import 'package:flutter/material.dart';

class WordCategory {
  const WordCategory({
    @required this.name, 
    @required this.color,
    this.isSpecial = false,
  });

  final Color color;
  final String name;
  final bool isSpecial;
}
