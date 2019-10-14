import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'package:path_provider/path_provider.dart';

class VocabularyBuilderDatabase {

  // Singleton instance
  static final VocabularyBuilderDatabase _database = VocabularyBuilderDatabase._();

  // Singleton getter
  static VocabularyBuilderDatabase get instance => _database;

  // Completer
  Completer<Database> _databaseCompleter;

  // Private constructor.
  VocabularyBuilderDatabase._();

  // Database getter
  Future<Database> get database async {

    if (_databaseCompleter == null) {
      // Create async.
      _databaseCompleter = Completer();
      // Open Database
      _openDatabase();
    }

    // Return the database.
    return _databaseCompleter.future;
  }

  // Open database
  Future<void> _openDatabase() async {
    // Find platform's directory.
    final Directory dir = await getApplicationDocumentsDirectory();
    // Find Database.
    final String databasePath = join(dir.path, 'VocabularyBuilder.db');
    // Open Database.
    final Database database = await databaseFactoryIo.openDatabase(databasePath);
    // Complete _databaseCompleter
    _databaseCompleter.complete(database);
  }

}
