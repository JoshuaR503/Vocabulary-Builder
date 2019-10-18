import 'package:sembast/sembast.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';
import 'package:vocabulary_builder/v2/data/database.dart';
import 'package:vocabulary_builder/v2/models/word/word.dart';

class WordDatabaseClient {

  static const String WORD_STORE_NAME = 'words';

  final _wordsStore = intMapStoreFactory.store(WORD_STORE_NAME);

  Future<Database> get _database async => await VocabularyBuilderDatabase.instance.database;

  Future<void> insert({Word data}) async {

    final VocabularyBuilderFunctions functions = VocabularyBuilderFunctions();

    // update word's fields.
    final wordData = data.toMap();

    final wordPronuntiationEn = wordData['en']['wordPronuntiation'];
    final wordPronuntiationEs = wordData['es']['wordPronuntiation'];

    wordData['en']['wordPronuntiation'] = await functions.saveToCache(wordPronuntiationEn);
    wordData['es']['wordPronuntiation'] = await functions.saveToCache(wordPronuntiationEs);

    await _wordsStore.add(await _database, wordData);
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
      word.isSaved = true;

      return word;
    })
    .toList();
  }
}
