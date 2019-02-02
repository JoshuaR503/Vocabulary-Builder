class PalabraGuardada {
  int id;
  String palabra;
  String traduccion;
  String date;

  PalabraGuardada({
    this.palabra, 
    this.traduccion,
    this.date
  });

  PalabraGuardada.withId(
    this.id,
    this.palabra, 
    this.traduccion,
    this.date
  );

  int get getId => id;
	String get getPalabra => palabra;
	String get getTraduccion => traduccion;
	String get getDate => date;

  set setPalabra(String newPalabra) {

    print(newPalabra);

		if (newPalabra.length <= 255) {
			this.palabra = newPalabra;
		}
	}

  set setTraduccion(String newTraduccion) {
		if (newTraduccion.length <= 255) {
			this.traduccion = newTraduccion;
		}
	}

  set setDate(String newDate) {
		this.date = newDate;
	}

  Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
      map['id'] = id;
    }
		map['palabra'] = palabra;
		map['traduccion'] = traduccion;
		map['date'] = date;

		return map;
	}

  PalabraGuardada.fromMapObject(Map<String, dynamic> map) {
		this.id = map['id'];
		this.palabra = map['palabra'];
		this.traduccion = map['traduccion'];
		this.date = map['date'];
	}

}