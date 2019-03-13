import 'package:moblie/model/palabra.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {

  final pathName = 'QuickGlish2.db';

  static DatabaseHelper _databaseHelper;
	static Database _database;

  String wordsTable = 'words_table';
	String colId = 'id';
	String colPalabra = 'palabra';
	String colTraduccion = 'traduccion';
  String colPasado = 'pasado';
  String colPresente = 'presente';
  String colPresenteContinuo = 'presenteContinuo';
  String colThirdPerson = 'thirdPerson';
  String colFuturo = 'futuro';
  String colDefinition = 'definicion';
  String colDefinitionEs = 'definicionEs';
  String colSynonyms = 'sinonimos';
  String colAntonyms = 'antonimos';
  String colExamples = 'ejemplos';
  String colType = 'tipo';
  String colPlural = 'plural';
  String colSingular = 'singular';
  String colNote = 'nota';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

		if (_databaseHelper == null) _databaseHelper = DatabaseHelper._createInstance(); 
		
		return _databaseHelper;
	}

  Future<Database> get database async {

		if (_database == null) _database = await initializeDatabase();
		
		return _database;
	}

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + pathName;

    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async => await db.execute("CREATE TABLE $wordsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colPalabra TEXT, $colTraduccion TEXT, $colPasado TEXT, $colPresente TEXT, $colPresenteContinuo TEXT, $colThirdPerson TEXT, $colFuturo TEXT, $colDefinition TEXT, $colDefinitionEs TEXT, $colSynonyms TEXT, $colAntonyms TEXT, $colExamples TEXT, $colType TEXT, $colPlural TEXT, $colSingular TEXT, $colNote TEXT, $colDate TEXT)");
 
  Future<List<Map<String, dynamic>>> fetchSavedDataMapList() async {
		Database db = await this.database;

		var result = await db.query(wordsTable, orderBy: '$colDate DESC');
		return result;
	}

  Future<int> savePalabra(Palabra palabra) async {
		Database db = await this.database;
		var result = await db.insert(wordsTable, palabra.toMap());
		return result;
	}

  Future<int> deletePalabra(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $wordsTable WHERE $colId = $id');
		return result;
	}

  Future <int> deleteTable() async {
    var db = await this.database;
    int result = await db.rawDelete('DROP TABLE $wordsTable');
		return result;
  }

  Future<List<Palabra>> fetchSavedDataList() async {

		var savedDataMapList = await fetchSavedDataMapList(); 
		int count = savedDataMapList.length;

		List<Palabra> savedDataList = List<Palabra>();

		for (int i = 0; i < count; i++) {
			savedDataList.add(Palabra.fromMapObject(savedDataMapList[i]));
		}

		return savedDataList;
	}
}