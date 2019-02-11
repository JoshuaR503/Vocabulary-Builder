import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dart:convert';
import 'dart:async';

import './palabra_guardada.model.dart';
import './palabra.model.dart';

import '../utils/settings.dart';
import '../utils/db.helper.dart';

mixin ConnectedModel on Model {
  bool _isLoading = true;
  bool _palabrasGuardadasIsLoading = true;
  
  int _selPalabraGuardadaId;
  List _palabras = [];
  List _palabrasGuardadas = [];
}

mixin PalabrasModel on ConnectedModel {
  FlutterTts _flutterTts = FlutterTts();
  DatabaseHelper _dbh = DatabaseHelper();  

  List<Palabra> get allPalabras => List.from(_palabras);
  List<PalabraGuardada> get allPalabrasGuardadas => List.from(_palabrasGuardadas);

  int get selectedPalabraIndex => _palabrasGuardadas.indexWhere((palabra) => palabra.id == _selPalabraGuardadaId);
  int get selectedPalabraId => _selPalabraGuardadaId;

  PalabraGuardada get selectedPalabra {
    if (selectedPalabraId == null) {
      return null;
    }

    return _palabrasGuardadas.firstWhere((palabra) => palabra.id == _selPalabraGuardadaId);
  }

  Future<Null> obtenerPalabras() async {
    _isLoading = true;
    notifyListeners();

    return http
      .get(url)
      .then<Null>((http.Response response) {

        final List<Palabra> fetchedPalabrasList = [];
        final List<dynamic> palabraListData = json.decode(response.body);

        if (palabraListData == null) {
          _isLoading = false;
          notifyListeners();
          return;
        } 

        palabraListData.forEach((dynamic palabraData) {

          final Palabra singlePalabra = Palabra(
            palabra: palabraData['palabra'],
            traduccion: palabraData['traduccion'],
            pasado: palabraData['pasado'],
            presente: palabraData['presente'],
            presenteContinuo: palabraData['presenteContinuo'],
            thirdPerson: palabraData['thirdPerson'],
            futuro: palabraData['futuro'],
            definicion: palabraData['definicion'],
            definicionEs: palabraData['definicionSpanish'],
            sinonimos: palabraData['sinonimos'],
            antonimos: palabraData['antonimos'],
            ejemplos: palabraData['ejemplos'],
            tipo: palabraData['tipo'],
            alt: palabraData['alt'],
          );

          fetchedPalabrasList.add(singlePalabra);
        });  

        _palabras = fetchedPalabrasList; 
        _isLoading = false;
        notifyListeners();        
      })
      .catchError((error) {
        _isLoading = false;
        notifyListeners();
        return;
      });
  }

  Future<Null> obtenerPalabrasGuardadas() async { 
    _palabrasGuardadasIsLoading = true;
    notifyListeners();

    Future<Database> dbFuture = _dbh.initializeDatabase();

		dbFuture
    .then((database) {
			Future<List<PalabraGuardada>> dataListFuture = _dbh.fetchSavedDataList();

			dataListFuture
        .then((response) {
          _palabrasGuardadas = response;
          _palabrasGuardadasIsLoading = false;
          notifyListeners();
        })
        .catchError((error) {
          _palabrasGuardadasIsLoading = false;
          notifyListeners();
          return;
        });
		})
    .catchError((error) {
      _palabrasGuardadasIsLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<int> save({
    String palabra, 
    String traduccion,
    String pasado,
    String presente,
    String presenteContinuo,
    String thirdPerson,
    String futuro,
    String definicion, 
    String definicionEs, 
    String sinonimos, 
    String antonimos, 
    String ejemplos, 
    String tipo
  }) async {

    PalabraGuardada singlePalabra = PalabraGuardada(
      palabra: palabra,
      traduccion: traduccion,
      pasado: pasado,
      presente: presente,
      presenteContinuo: presenteContinuo,
      thirdPerson: thirdPerson,
      futuro: futuro,
      definicion: definicion,
      definicionEs: definicionEs,
      sinonimos: sinonimos,
      antonimos: antonimos,
      ejemplos: ejemplos,
      tipo: tipo,
      date: DateFormat.yMMMd().format(DateTime.now())
    );

    int result = await _dbh.savePalabra(singlePalabra);

    return result;
  }

  void deletePalabraGuardada() {
    _dbh.deletePalabra(selectedPalabra.id);
    _palabrasGuardadas.removeAt(selectedPalabraIndex);
    _selPalabraGuardadaId = null;
  }

  void selectPalabra(int palabraId) {
    _selPalabraGuardadaId = palabraId;

    if (palabraId != null) {
      notifyListeners();
    }
  }

  void speak(String text) async { 
    _flutterTts.setLanguage("en-US");
    _flutterTts.setPitch(1.0);
    _flutterTts.setSpeechRate(0.8);
    _flutterTts.speak(text);
  }
} 

mixin UtilityModel on ConnectedModel {
  bool get isLoading => _isLoading;
  bool get palabrasGuardadasIsLoading => _palabrasGuardadasIsLoading;
}