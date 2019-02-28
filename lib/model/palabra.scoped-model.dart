import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibrate/vibrate.dart';
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
  bool _seen = false;

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

  Future<Null> obtenerPalabras({bool loadingIndicator = false}) async {
    
    return http
      .get(url)
      .then<Null>((http.Response response) {

        if (loadingIndicator) {
          _isLoading = true;
          notifyListeners();
        } else {
          _isLoading = false;
          notifyListeners();
        }

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

            plural: palabraData['plural'],
            singular: palabraData['singular'],
            nota: palabraData['nota'],
            alt: palabraData['alt'],
          );

          print('Plural ${singlePalabra.plural}, Singular ${singlePalabra.singular}');
          
          fetchedPalabrasList.add(singlePalabra);
        });

        

        _palabras = fetchedPalabrasList; 

        if (loadingIndicator) {
          _isLoading = false;
          notifyListeners();
        }       
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

  Future<int> save({Palabra palabraData}) async {

    PalabraGuardada singlePalabra = PalabraGuardada(
      palabra: palabraData.palabra,
      traduccion: palabraData.traduccion,
      pasado: palabraData.pasado,
      presente: palabraData.presente,
      presenteContinuo: palabraData.presenteContinuo,
      thirdPerson: palabraData.thirdPerson,
      futuro: palabraData.futuro,
      definicion: palabraData.definicion,
      definicionEs: palabraData.definicionEs,
      sinonimos: palabraData.sinonimos,
      antonimos: palabraData.antonimos,
      ejemplos: palabraData.ejemplos,
      tipo: palabraData.tipo,
      plural: palabraData.plural,
      singular: palabraData.singular,
      nota: palabraData.nota,
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
  bool get seen => _seen;

  void obtenerData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool response = prefs.getBool('seen');

    if (response) {
      _seen = true;
    } else {
      _seen = false;
    }
  }

  Future<Null> setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }

  void sendFeedback() async {

    bool canVibrate = await Vibrate.canVibrate;

    if (canVibrate) {
      Vibrate.vibrate();
    }
  }
}