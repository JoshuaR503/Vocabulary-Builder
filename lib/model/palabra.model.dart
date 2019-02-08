import 'package:flutter/material.dart';

class Palabra {
  final String palabra;
  final String traduccion;
  final String definicion;
  final String definicionEs;
  final String sinonimos;
  final String antonimos;
  final String ejemplos;
  final String tipo;
  final bool alt;

  Palabra({
    @required this.palabra, 
    @required this.traduccion,
    @required this.definicion,
    @required this.definicionEs,
    @required this.sinonimos,
    @required this.antonimos,
    @required this.ejemplos,
    @required this.tipo,
    @required this.alt, 
  });
}