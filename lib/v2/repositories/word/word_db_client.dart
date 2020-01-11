import 'package:sembast/sembast.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';
import 'package:vocabulary_builder/v2/data/database.dart';
import 'package:vocabulary_builder/v2/models/word/word.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';

class WordDatabaseClient {

  final SettingsRepository settingsRepository = SettingsRepository();
  final StoreRef<int, Map<String, dynamic>>  _wordsStore = intMapStoreFactory.store('wordss');

  // Sembast Database.
  Future<Database> get _database async => await VocabularyBuilderDatabase.instance.database;

  /// Saves a Word into the database.
  Future<int> insert({Word data}) async {
    try {

      final VocabularyBuilderFunctions functions = VocabularyBuilderFunctions();

      // update word's fields.
      final wordData = data.toMap();
      final firstLanguage = wordData['firstLanguage']['wordPronuntiation'];
      final targetLanguage = wordData['targetLanguage']['wordPronuntiation'];

      // Save audio files to device.
      wordData['firstLanguage']['wordPronuntiation'] = await functions.saveToCache(firstLanguage);
      wordData['targetLanguage']['wordPronuntiation'] = await functions.saveToCache(targetLanguage);

      // Store word into database.
      return await _wordsStore.add(await _database, wordData);
      
    } catch (e) {
      // Not-so-great error handling.
      print('\n\n\nERROR WHILE SAVING WORD: $e\n\n\n');

      return null;
    }
  }

  /// Deletes [word] by id.
  Future<void> delete({Word word}) async {
    
    // Filert and Finder.
    final Filter filter = Filter.byKey(word.id);
    final Finder finder = Finder(filter: filter);

    // Delete word from database.
    await _wordsStore.delete(
      await _database,
      finder: finder
    );
  }

  /// Deletes all words from databse.
  Future<void> deleteAll() async {
    await _wordsStore.delete(await _database);
  }
  
  /// Fetches words from database.
  Future<List<Word>> fetchSavedWords() async {

    final Map<String, String> langMetaData = await settingsRepository.getUserLanguage();
    final Finder finder = Finder(sortOrders: [SortOrder(Field.key, false)]);

    // Fetch all words.
    final response = await _wordsStore.find(
      await _database,
      finder: finder
    );

    try {
      // Word processing handler.
      return response
      .map((snapshot) {
        final Word word = Word.fromMap(snapshot.value, langMetaData);
        word.id = snapshot.key;
        word.isSaved = true;
        
        return word;
      })
      .toList();
      
    } catch (e) {
      // Not-so-great error handling.
      return null;
    }
  }
}
