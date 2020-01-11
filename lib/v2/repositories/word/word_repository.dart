import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/word/word_db_client.dart';

class WordRepository {
  
  // Words Client.
  final WordDatabaseClient _client = WordDatabaseClient();

  // Fetch all saved words.
  Future<List<Word>> fetchWords() async {
    return await this._client.fetchSavedWords();
  }

  // Save a new word.
  Future<int> insertWord({Word word}) async {
    return await this._client.insert(data: word);
  }
  
  // Delete a single saved word.
  Future<void> delete({Word word}) async {
    await this._client.delete(word: word);
  }

  // Delete all saved words.
  Future<void> deleteAll() async {
    await this._client.deleteAll();
  }
}