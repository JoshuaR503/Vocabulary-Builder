
import 'package:sembast/sembast.dart';
import 'package:vocabulary_builder/v2/data/database.dart';
import 'package:vocabulary_builder/v2/models/word/word.dart';

class WordDatabaseClient {

  static const String WORD_STORE_NAME = 'words';

  final _wordsStore = intMapStoreFactory.store(WORD_STORE_NAME);

  Future<Database> get _database async => await VocabularyBuilderDatabase.instance.database;

  Future<void> insert({ Word data}) async {
    await _wordsStore.add(await _database, data.toJson());
  }
  
  Future<List<Word>> fetchSavedWords() async {
    final Finder finder = Finder(sortOrders: [SortOrder('dbId')]);
    final List<RecordSnapshot<int, Map<String, dynamic>>> response = await _wordsStore.find(
      await _database,
      finder: finder
    );

    return response
    .map((snapshot) => Word.fromMap(snapshot.value))
    .toList();

  }
}