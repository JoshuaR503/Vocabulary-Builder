class PalabraGuardada {
  int id;
  String palabra;
  String traduccion;
  String pasado;
  String presente;
  String presenteContinuo;
  String thirdPerson;
  String futuro;
  String definicion;
  String definicionEs;
  String sinonimos;
  String antonimos;
  String ejemplos;
  String tipo;
  String date;

  PalabraGuardada({
    this.palabra, 
    this.traduccion,
    this.pasado,
    this.presente,
    this.presenteContinuo,
    this.thirdPerson,
    this.futuro,
    this.definicion,
    this.definicionEs,
    this.sinonimos,
    this.antonimos,
    this.ejemplos,
    this.tipo,
    this.date
  });

  PalabraGuardada.withId(
    this.id,
    this.palabra,
    this.traduccion,
    this.pasado,
    this.presente,
    this.presenteContinuo,
    this.thirdPerson,
    this.futuro,
    this.definicion,
    this.definicionEs,
    this.sinonimos,
    this.antonimos,
    this.ejemplos,
    this.tipo,
    this.date
  );

  Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();

		if (id != null) map['id'] = id;
    
		map['palabra'] = palabra;
		map['traduccion'] = traduccion;
    map['pasado'] = pasado;
    map['presente'] = presente;
    map['presenteContinuo'] = presenteContinuo;
    map['thirdPerson'] = thirdPerson;
    map['futuro'] = futuro;
    map['definicion'] = definicion;
    map['definicionEs'] = definicionEs;
    map['sinonimos'] = sinonimos;
    map['antonimos'] = antonimos;
    map['ejemplos'] = ejemplos;
    map['tipo'] = tipo;
		map['date'] = date;

		return map;
	}

  PalabraGuardada.fromMapObject(Map<String, dynamic> map) {
		this.id = map['id'];
		this.palabra = map['palabra'];
		this.traduccion = map['traduccion'];
    this.pasado = map['pasado'];
    this.presente = map['presente'];
    this.presenteContinuo = map['presenteContinuo'];
    this.thirdPerson = map['thirdPerson'];
    this.futuro = map['futuro'];
    this.definicion = map['definicion'];
    this.definicionEs = map['definicionEs'];
    this.sinonimos = map['sinonimos'];
    this.antonimos = map['antonimos'];
    this.ejemplos =  map['ejemplos'];
    this.tipo = map['tipo'];
		this.date = map['date'];
	}
}