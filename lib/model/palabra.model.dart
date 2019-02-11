import 'package:flutter/material.dart';

class Palabra {
  final String palabra;
  final String traduccion;
  final String pasado;
  final String presente;
  final String presenteContinuo;
  final String thirdPerson;
  final String futuro;
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
    this.pasado,
    this.presente,
    this.presenteContinuo,
    this.thirdPerson,
    this.futuro,
    this.definicion,
    this.definicionEs,
    this.sinonimos,
    this.antonimos,
    @required this.ejemplos,
    @required this.tipo,
    @required this.alt, 
  });
}