import 'package:flutter/material.dart';

class PalabraInfo {
  final String palabra;
  final String traduccion;
  final List synonyms;
  final String meaning;
  final List examples;
  final String type;
  final bool alt;

  PalabraInfo({
    @required this.palabra, 
    @required this.traduccion,
    @required this.synonyms,
    @required this.meaning,
    @required this.examples,
    @required this.type,
    @required this.alt, 
  });
}