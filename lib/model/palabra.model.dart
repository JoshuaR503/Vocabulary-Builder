import 'package:flutter/material.dart';

class Palabra {
  final String palabra;
  final String traduccion;

  Palabra({
    @required this.palabra, 
    @required this.traduccion
  });

  factory Palabra.fromJson(Map<String, dynamic> json){
    return new Palabra(
      palabra: json['palabra'],
      traduccion: json['traduccion'],
    );
  }
}