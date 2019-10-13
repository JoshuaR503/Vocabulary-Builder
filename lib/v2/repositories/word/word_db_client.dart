import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';
import 'package:vocabulary_builder/v2/data/database.dart';
import 'package:vocabulary_builder/v2/models/word/word.dart';

class WordDatabaseClient {

  static const String WORD_STORE_NAME = 'words';

  final _wordsStore = intMapStoreFactory.store(WORD_STORE_NAME);

  Future<Database> get _database async => await VocabularyBuilderDatabase.instance.database;

  Future<void> insert({ Word data}) async {
    await _wordsStore.add(await _database, data.toMap());
  }
  
  Future<List<Word>> fetchSavedWords() async {

    final finder = Finder(sortOrders: [SortOrder('dbId')]);
    final rs = await _wordsStore.find(
      await _database,
      finder: finder
    );

    return rs.map((snapshot) {

      final word = Word.fromMap(snapshot.value);

      word.dbId = snapshot.key;

      return word;

    }).toList();
  }

  Future<void> delete(Word word) async {
    final finder = Finder(filter: Filter.byKey(word.dbId));

    await _wordsStore.delete(
      await _database,
      finder: finder
    );
  }
}