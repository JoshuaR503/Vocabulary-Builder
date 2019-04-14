import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibrate/vibrate.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dart:convert';
import 'dart:async';

import './palabra.model.dart';

import '../utils/settings.dart';
import '../utils/db.helper.dart';

mixin ConnectedModel on Model {
  bool _isLoading = true;
  bool _palabrasGuardadasIsLoading = true;
  bool _seen = false;

  int _selPalabraGuardadaId;

  String _userLang;
  List _palabras = [];
  List _palabrasGuardadas = [];
  List _busqueda = [];
}

mixin PalabrasModel on ConnectedModel {

  Future<String> uLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userlang = prefs.getString('user_lang');
    _userLang = userlang;

    return userlang;
  }

  DatabaseHelper _dbh = DatabaseHelper();  

  List<Palabra> get allPalabras => List.from(_palabras);
  List<Palabra> get allPalabrasEncontradas => List.from(_busqueda);
  List<Palabra> get allPalabrasGuardadas => List.from(_palabrasGuardadas);

  int get selectedPalabraIndex => _palabrasGuardadas.indexWhere((palabra) => palabra.id == _selPalabraGuardadaId);
  int get selectedPalabraId => _selPalabraGuardadaId;

  Palabra get selectedPalabra {
    if (selectedPalabraId == null) {
      return null;
    }

    return _palabrasGuardadas.firstWhere((palabra) => palabra.id == _selPalabraGuardadaId);
  }

  Future<Null> obtenerPalabras({bool loadingIndicator = false}) async {

    final String lang = await uLang();
    print('$lang');
    

    return http
      .get('$baseUrl/api/v3/azar?limit=6&lang=$lang')
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

        final String requestedLang = _userLang.toUpperCase();

        String secondLang;

        if (requestedLang == 'ES') {
          secondLang = 'EN';
        } else if (requestedLang == 'EN') {
          secondLang = 'ES';
        }

        print('$requestedLang, $secondLang');

        palabraListData.forEach((dynamic palabraData) {

          final Palabra singlePalabra = Palabra(
            palabra: palabraData['palabra'],
            traduccion: palabraData['traduccion'],
            dificultad: palabraData['dificultad'],

            primeraPersona: palabraData['primeraPersona$requestedLang'],
            segundaPersona: palabraData['segundaPersona$requestedLang'],
            terceraPersona: palabraData['terceraPersona$requestedLang'],

            presente: palabraData['presente$requestedLang'],
            presenteContinuo: palabraData['presenteContinuo$requestedLang'],
            pasado: palabraData['pasado$requestedLang'],
            futuro: palabraData['futuro$requestedLang'],

            sinonimos: palabraData['sinonimos$secondLang'],
            antonimos: palabraData['antonimos$secondLang'],

            definicion: palabraData['definicion$requestedLang'],
            definicion2: palabraData['definicion$secondLang'],
            
            ejemplo: palabraData['ejemplo$secondLang'],
            ejemplo2: palabraData['ejemplo2$secondLang'],

            categoriaGramatical: palabraData['categoriaGramatical$requestedLang'],

            nota: palabraData['nota$secondLang'],
          );

          print('${singlePalabra.ejemplo}');
          
          
          fetchedPalabrasList.add(singlePalabra);
        });

        _palabras = fetchedPalabrasList; 
        
        if (loadingIndicator) {
          _isLoading = false;
          notifyListeners();
        } else {
          notifyListeners();
        }
      })
      .catchError((error) {
        _isLoading = false;
        print('ERROR + $error');
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
			Future<List<Palabra>> dataListFuture = _dbh.fetchSavedDataList();

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

    Palabra singlePalabra = Palabra(
      palabra: palabraData.palabra,
      traduccion: palabraData.traduccion,
      dificultad: palabraData.dificultad,

      primeraPersona: palabraData.primeraPersona,
      segundaPersona: palabraData.segundaPersona,
      terceraPersona: palabraData.terceraPersona,

      presente: palabraData.presente,
      presenteContinuo: palabraData.presenteContinuo,
      pasado: palabraData.pasado,
      futuro: palabraData.futuro,

      sinonimos: palabraData.sinonimos,
      antonimos: palabraData.antonimos,

      definicion: palabraData.definicion,
      definicion2: palabraData.definicion2,

      ejemplo: palabraData.ejemplo,
      ejemplo2: palabraData.ejemplo2,

      categoriaGramatical: palabraData.categoriaGramatical,
      categoriaGramatical2: palabraData.categoriaGramatical2,

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
} 

mixin UtilityModel on ConnectedModel {
  FlutterTts _textToSpeech = FlutterTts();

  bool get isLoading => _isLoading;
  bool get palabrasGuardadasIsLoading => _palabrasGuardadasIsLoading;
  bool get seen => _seen;
  String get userLang => _userLang;

  void obtenerData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ver si el usuario ya visito la introducion
    final bool response = prefs.getBool('seen');

    if (response == true) {
      _seen = true;
    } else if (response != true) {
      _seen = false;
    }
    
    // Obtener el idioma de el usuario
    final String userlang = prefs.getString('user_lang');
    _userLang = userlang;
  }

  Future<Null> setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }

  Future<Null> setLang(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_lang', language);
  }

  void sendFeedback([bool error]) async {
    bool canVibrate = await Vibrate.canVibrate;

    if (canVibrate) {
      if (error) {
        Vibrate.vibrateErr();
      } else {
        Vibrate.vibrate();
      }
    }
  }

  void speak(String text) async {
    _textToSpeech.setPitch(1.0);
    _textToSpeech.setSpeechRate(0.8);

    if (_userLang == 'es') {
      _textToSpeech.setLanguage('en_US');
    } else {
      _textToSpeech.setLanguage('es_ES');
    }

    _textToSpeech.speak(text);
  }
}