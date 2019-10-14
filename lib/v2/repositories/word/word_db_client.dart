
import 'package:sembast/sembast.dart';
import 'package:vocabulary_builder/v2/data/database.dart';
import 'package:vocabulary_builder/v2/models/word/word.dart';

class WordDatabaseClient {

  static const String WORD_STORE_NAME = 'words';

  final _wordsStore = intMapStoreFactory.store(WORD_STORE_NAME);

  Future<Database> get _database async => await VocabularyBuilderDatabase.instance.database;

  Future<void> insert({Word data}) async {
    await _wordsStore.add(await _database, data.toMap());
  }

  Future<void> delete({Word word}) async {

    final Filter filter = Filter.byKey(word.id);
    final Finder finder = Finder(filter: filter);

    await _wordsStore.delete(
      await _database,
      finder: finder
    );
  }

  Future<void> deleteAll() async {
    await _wordsStore.delete(await _database);
  }
  
  Future<List<Word>> fetchSavedWords() async {

    final Finder finder = Finder(
      sortOrders: [SortOrder(Field.key, false)]
    );

    final response = await _wordsStore.find(
      await _database,
      finder: finder
    );

    return response
    .map((snapshot) {

      final Word word = Word.fromMap(snapshot.value);
      word.id = snapshot.key;

      return word;
    })
    .toList();
  }
}
