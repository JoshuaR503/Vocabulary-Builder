import 'package:flutter/material.dart' show required;

class Palabra {
  int id;
  @required String palabra;
  @required String traduccion;
  String palabraPronunciacion;
  String traduccionPronunciacion;
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
  String ejemplo2;
  String categoriaGramatical;
  String categoriaGramatical2;
  String nota;
  String date;

  Palabra({
    @required this.palabra, 
    @required this.traduccion,
    this.palabraPronunciacion,
    this.traduccionPronunciacion,
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
    this.ejemplo2,
    this.definicion,
    this.definicion2,
    this.categoriaGramatical,
    this.categoriaGramatical2,
    this.nota,
    this.date,
  });

  Palabra.withId({
    @required this.palabra, 
    @required this.traduccion,
    this.palabraPronunciacion,
    this.traduccionPronunciacion,
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
    this.ejemplo2,
    this.definicion,
    this.definicion2,
    this.nota,
    this.date,
    this.categoriaGramatical,
    this.categoriaGramatical2,
    this.id
  });

    Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();

		if (id != null) map['id'] = id;
    
		map['palabra'] = palabra;
		map['traduccion'] = traduccion;
    map['palabraPronunciacion'] = palabraPronunciacion;
    map['traduccionPronunciacion'] = traduccionPronunciacion;
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
    map['ejemplo2'] = ejemplo2;
    map['categoriaGramatical'] = categoriaGramatical;
    map['categoriaGramatical2'] = categoriaGramatical2;
    map['nota'] = nota;
		map['date'] = date;

		return map;
	}

  Palabra.fromMapObject(Map<String, dynamic> map) {
		this.id = map['id'];
		this.palabra = map['palabra'];
		this.traduccion = map['traduccion'];
    this.palabraPronunciacion = map['palabraPronunciacion'];
    this.traduccionPronunciacion = map['traduccionPronunciacion'];
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
    this.ejemplo2 = map['ejemplo2'];
    this.categoriaGramatical = map['categoriaGramatical'];
    this.categoriaGramatical2 = map['categoriaGramatical2'];
    this.nota = map['nota'];
		this.date = map['date'];
	}
}