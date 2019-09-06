import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sqflite/sqflite.dart';

import 'package:intl/intl.dart';

import 'package:vocabulary_builder/model/palabra.model.dart';
import 'package:vocabulary_builder/utils/db.helper.dart';
import 'package:vocabulary_builder/utils/http.dart';
import 'package:vocabulary_builder/utils/settings.dart';

import 'dart:async';
import 'dart:io';

mixin ConnectedModel on Model {
  bool _isLoading = true;
  bool _limitReached = false;
  bool _palabrasGuardadasIsLoading = true;
  bool _seen = false;

  bool _internetConnected = false;

  int _selPalabraGuardadaId;
  int _responseMessage;

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
  int get responseMessage => _responseMessage;

  bool get isLoading => _isLoading;
  bool get palabrasGuardadasIsLoading => _palabrasGuardadasIsLoading;
  bool get limitReached => _limitReached;

  Palabra get selectedPalabra {
    if (selectedPalabraId == null) {
      return null;
    }

    return _palabrasGuardadas.firstWhere((palabra) => palabra.id == _selPalabraGuardadaId);
  }

  Future<Null> obtenerPalabras({bool loadingIndicator = false}) async {

    final String lang = await uLang();  
    final String prodURL = '$baseUrl/api/v3/palabras?limit=6&lang=$lang&key=JosshuAP50@KelReySSl@hiddenKEY';

    final SimpleHttpClient httpClient = new SimpleHttpClient();
    final httpResponse = httpClient.fetchData(url: prodURL, token: null);


    httpResponse
    .then((data) {
      this._isLoading = loadingIndicator;
      this.notifyListeners();
      final dynamic response = data;
      final List<Palabra> fetchedPalabrasList = this.convertResponseToList(response);
      if (loadingIndicator) {
        this._palabras = fetchedPalabrasList; 
        this._isLoading = false;
        this.notifyListeners();
      } else {
        this._palabras = fetchedPalabrasList; 
        this.notifyListeners();
      }
    })
    .catchError((e) {
      this._palabras = [];
      if (httpClient.statusCode == 503) {
        this._responseMessage = 503;
        this._isLoading = false;
        this.notifyListeners();
      } else if (httpClient.statusCode == 429) {
        this._limitReached = true;
        this._responseMessage = 429;
        this._isLoading = false;
        this.notifyListeners();
      } else {
        this._isLoading = false;
        this.notifyListeners();
      }
    });
  }

  Future<Null> obtenerPalabrasGuardadas() async { 
    final Future<Database> dbFuture = _dbh.initializeDatabase();

    this._palabrasGuardadasIsLoading = true;
    this.notifyListeners();

		dbFuture
    .then((database) {
			final Future<List<Palabra>> dataListFuture = _dbh.fetchSavedDataList();

			dataListFuture
        .then((response) {
          _palabrasGuardadas = response;
          this._palabrasGuardadasIsLoading = false;
          this.notifyListeners();
        })
        .catchError((error) {
          this._palabrasGuardadasIsLoading = false;
          this.notifyListeners();
          return;
        });
		})
    .catchError((error) {
      this._palabrasGuardadasIsLoading = false;
      this.notifyListeners();
      return;
    });
  }

  Future<int> save({Palabra palabraData}) async {

    Palabra singlePalabra = Palabra(
      palabra: palabraData.palabra,
      palabraPronunciacion: await this.saveToChache(palabraData.palabraPronunciacion),

      traduccion: palabraData.traduccion,
      traduccionPronunciacion: await this.saveToChache(palabraData.traduccionPronunciacion),
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

    print('${singlePalabra.palabraPronunciacion}');

  
    int result = await _dbh.savePalabra(singlePalabra);

    return result;
  }

  List<Palabra> convertResponseToList(List data) {
    final List<Palabra> fetchedPalabrasList = [];
    final String requestedLang = _userLang.toUpperCase();
    final String secondLang = requestedLang == 'ES' ? 'EN' : 'ES';

    data.forEach((dynamic palabraData) {
      final Palabra singlePalabra = Palabra(
        palabra: palabraData['palabra'],
        palabraPronunciacion: palabraData['palabraPronunciacion'],
        traduccion: palabraData['traduccion'],
        traduccionPronunciacion: palabraData['traduccionPronunciacion'],
        dificultad: palabraData['dificultad'],
        primeraPersona: palabraData['primeraPersona$secondLang'],
        segundaPersona: palabraData['segundaPersona$secondLang'],
        terceraPersona: palabraData['terceraPersona$secondLang'],
        presente: palabraData['presente$secondLang'],
        presenteContinuo: palabraData['presenteContinuo$secondLang'],
        pasado: palabraData['pasado$secondLang'],
        futuro: palabraData['futuro$secondLang'],
        sinonimos: palabraData['sinonimos$secondLang'],
        antonimos: palabraData['antonimos$secondLang'],
        definicion: palabraData['definicion$requestedLang'],
        definicion2: palabraData['definicion$secondLang'],
        ejemplo: palabraData['ejemplo$secondLang'],
        ejemplo2: palabraData['ejemplo2$secondLang'],
        categoriaGramatical: palabraData['categoriaGramatical$requestedLang'],
        nota: palabraData['nota$secondLang'],
      );

      fetchedPalabrasList.add(singlePalabra);
    });

    return fetchedPalabrasList;
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

  Future<String> saveToChache(String url) async {
    final FileInfo file =  await DefaultCacheManager().downloadFile(url);
    final String fileUrl = file.file.path;

    print('file saved: $fileUrl');
  
    return fileUrl;
  }

  Future<String> getFromCache(String url) async {
    final FileInfo file = await DefaultCacheManager().getFileFromCache(url);
    final String fileUrl = file.file.path;

    print('file saved: $fileUrl');
  
    return fileUrl;
  }

  void deleteFile(String url) async {
    await DefaultCacheManager().removeFile(url);
  }
} 

mixin UtilityModel on ConnectedModel {

  bool get seen => _seen;
  bool get internetConnected => _internetConnected;
  
  String get userLang => _userLang;

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userlang = prefs.getString('user_lang');
    final bool response = prefs.getBool('seen');
    
    this._userLang = userlang;
    this._seen = response != null 
    ? true
    : false;
    
    this.checkInternetConnection();
  }

  Future<Null> checkInternetConnection() async {
    
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty) {
        this._internetConnected = true;
      }

    } catch (_) {
      this._internetConnected = false;
    }
  }

  Future<Null> setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    this._seen = true;
    prefs.setBool('seen', true);
  }

  Future<Null> setLang(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_lang', language);
  }

  Future<int> playAduio({String url}) {

    print('url given: $url');

    final AudioPlayer audioPlayer = AudioPlayer();

    return audioPlayer
    .play(url)
    .then((_) => 0)
    .catchError((error) => 1);
  }

  void sendFeedback([bool error]) async {
    
  }

  String cleanString(String url) {
    final String dirtyString = url;
    final String cleanString = replaceWhiteSpace(dirtyString);

    print('$dirtyString, $cleanString');

    return cleanString;
  }

  String replaceWhiteSpace(String text) {
    return text.replaceAll(RegExp(r"\s+\b|\b\s"), "-");
  }
}