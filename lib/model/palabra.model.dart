import 'package:flutter/material.dart';

class Palabra {
  int id;
  @required String palabra;
  @required String traduccion;
  String dificultad;
  String primeraPersona;
  String segundaPersona;
  String terceraPersona;
  String pasado;
  String presente;
  String presenteContinuo;
  String futuro;
  String sinonimos;
  String antonimos;
  String definicion;
  String definicion2;
  String ejemplo;
  String categoriaGramatical;
  String nota;
  String date;

  Palabra({
    @required this.palabra, 
    @required this.traduccion,
    this.dificultad,
    this.primeraPersona,
    this.segundaPersona,
    this.terceraPersona,
    this.pasado,
    this.presente,
    this.presenteContinuo,
    this.futuro,
    this.sinonimos,
    this.antonimos,
    this.ejemplo,
    this.definicion,
    this.definicion2,
    String categoriaGramatical,
    this.nota,
    this.date,
  });

  Palabra.withId({
    @required this.palabra, 
    @required this.traduccion,
    this.dificultad,
    this.primeraPersona,
    this.segundaPersona,
    this.terceraPersona,
    this.pasado,
    this.presente,
    this.presenteContinuo,
    this.futuro,
    this.sinonimos,
    this.antonimos,
    this.ejemplo,
    this.definicion,
    this.definicion2,
    this.nota,
    this.date,
    String categoriaGramatical,
    this.id
  });

    Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();

		if (id != null) map['id'] = id;
    
		map['palabra'] = palabra;
		map['traduccion'] = traduccion;
    map['dificultad'] = dificultad;
    map['primeraPersona'] = primeraPersona;
    map['segundaPersona'] = segundaPersona;
    map['terceraPersona'] = terceraPersona;
    map['pasado'] = pasado;
    map['presente'] = presente;
    map['presenteContinuo'] = presenteContinuo;
    map['futuro'] = futuro;
    map['sinonimos'] = sinonimos;
    map['antonimos'] = antonimos;
    map['definicion'] = definicion;
    map['definicion2'] = definicion2;
    map['ejemplo'] = ejemplo;
    map['categoriaGramatical'] = categoriaGramatical;
    map['nota'] = nota;
		map['date'] = date;

		return map;
	}

  Palabra.fromMapObject(Map<String, dynamic> map) {
		this.id = map['id'];
		this.palabra = map['palabra'];
		this.traduccion = map['traduccion'];
    this.dificultad = map['dificultad'];
    this.primeraPersona = map['primeraPersona'];
    this.segundaPersona = map['segundaPersona'];
    this.terceraPersona = map['terceraPersona'];
    this.pasado = map['pasado'];
    this.presente = map['presente'];
    this.presenteContinuo = map['presenteContinuo'];
    this.futuro = map['futuro'];
    this.sinonimos =  map['sinonimos'];
    this.antonimos = map['antonimos'];
    this.definicion = map['definicion'];
    this.definicion2 = map['definicion2'];
    this.ejemplo = map['ejemplo'];
    this.categoriaGramatical = map['categoriaGramatical'];
    this.nota = map['nota'];
		this.date = map['date'];
	}
}