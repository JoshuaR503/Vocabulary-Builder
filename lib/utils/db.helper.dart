import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../model/palabra_guardada.model.dart';

import 'dart:async';
import 'dart:io';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
	static Database _database;

  String wordsTable = 'words_table';
	String colId = 'id';
	String colPalabra = 'palabra';
	String colTraduccion = 'traduccion';
  String colDefinition = 'definicion';
  String colDefinitionEs = 'definicionEs';
  String colSynonyms = 'sinonimos';
  String colAntonyms = 'antonimos';
  String colExamples = 'ejemplos';
  String colType = 'tipo';
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
		String path = directory.path + 'palabras2abcd.db';

    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async => await db.execute("CREATE TABLE $wordsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colPalabra TEXT, $colTraduccion TEXT, $colDefinition TEXT, $colDefinitionEs TEXT, $colSynonyms TEXT, $colAntonyms TEXT, $colExamples TEXT, $colType TEXT, $colDate TEXT)");
	
  Future<List<Map<String, dynamic>>> fetchSavedDataMapList() async {
		Database db = await this.database;

		var result = await db.query(wordsTable, orderBy: '$colDate ASC');
		return result;
	}

  Future<int> savePalabra(PalabraGuardada palabra) async {
		Database db = await this.database;
		var result = await db.insert(wordsTable, palabra.toMap());
		return result;
	}

  Future<int> deletePalabra(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $wordsTable WHERE $colId = $id');
		return result;
	}

  Future<List<PalabraGuardada>> fetchSavedDataList() async {

		var savedDataMapList = await fetchSavedDataMapList(); 
		int count = savedDataMapList.length;

		List<PalabraGuardada> savedDataList = List<PalabraGuardada>();

		for (int i = 0; i < count; i++) {
			savedDataList.add(PalabraGuardada.fromMapObject(savedDataMapList[i]));
		}

		return savedDataList;
	}
}