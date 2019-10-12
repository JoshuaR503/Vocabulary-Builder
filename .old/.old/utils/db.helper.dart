import 'package:vocabulary_builder/model/palabra.model.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:sqflite/sqflite.dart';

import 'dart:async';
import 'dart:io';

class DatabaseHelper {

  final pathName = 'productionVocabularyBuilderDBX3.db';

  static DatabaseHelper _databaseHelper;
	static Database _database;

  String wordsTable = 'words_table';
	String colId = 'id';
	String colPalabra = 'palabra';
  String colPalabraPronunciacion = 'palabraPronunciacion';
	String colTraduccion = 'traduccion';
  String colTraduccionPronunciacion = 'traduccionPronunciacion';
  String colDificultad = 'dificultad';

  String colPrimeraPersona = 'primeraPersona';
  String colSegundaPersona = 'segundaPersona';
  String colTerceraPersona = 'terceraPersona';

  String colPresente = 'presente';
  String colPresenteContinuo = 'presenteContinuo';
  String colPasado = 'pasado';
  String colFuturo = 'futuro';

  String colSynonyms = 'sinonimos';
  String colAntonyms = 'antonimos';
  String colDefinicion = 'definicion';
  String colDefinicion2 = 'definicion2';

  String colEjemplo = 'ejemplo';
  String colEjemplo2 = 'ejemplo2';

  String colCategoriaGramatical = 'categoriaGramatical';
  String colCategoriaGramatical2 = 'categoriaGramatical2';

  String colNote = 'nota';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

		if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); 
    }
		
		return _databaseHelper;
	}

  Future<Database> get database async {

		if (_database == null) _database = await initializeDatabase();
		
		return _database;
	}

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = p.join(directory.toString(), pathName);

    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async => await db.execute("CREATE TABLE $wordsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colPalabra TEXT, $colPalabraPronunciacion TEXT, $colTraduccion TEXT, $colTraduccionPronunciacion TEXT, $colDificultad TEXT, $colPrimeraPersona TEXT, $colSegundaPersona TEXT, $colTerceraPersona TEXT, $colPresente TEXT, $colPresenteContinuo TEXT, $colPasado TEXT, $colFuturo TEXT, $colSynonyms TEXT, $colAntonyms TEXT, $colDefinicion TEXT, $colDefinicion2 TEXT, $colEjemplo TEXT, $colEjemplo2 TEXT, $colCategoriaGramatical TEXT, $colCategoriaGramatical2 TEXT, $colNote TEXT, $colDate TEXT)");
 
  Future<List<Map<String, dynamic>>> fetchSavedDataMapList() async {
		final Database db = await this.database;
		final dynamic result = await db.query(wordsTable, orderBy: '$colId DESC');

		return result;
	}

  Future<int> savePalabra(Palabra palabra) async {
		final Database db = await this.database;
		final dynamic result = await db.insert(wordsTable, palabra.toMap());

		return result;
	}

  Future<int> deletePalabra(int id) async {
		final Database db = await this.database;
		final int result = await db.rawDelete('DELETE FROM $wordsTable WHERE $colId = $id');

		return result;
	}

  Future <int> deleteTable() async {
    final Database db = await this.database;
    final int result = await db.rawDelete('DROP TABLE $wordsTable');

		return result;
  }

  Future<List<Palabra>> fetchSavedDataList() async {
		final dynamic savedDataMapList = await fetchSavedDataMapList(); 
		final int count = savedDataMapList.length;

		List<Palabra> savedDataList = List<Palabra>();

		for (int i = 0; i < count; i++) {
			savedDataList.add(Palabra.fromMapObject(savedDataMapList[i]));
		}

		return savedDataList;
	}
}