import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/word/word_db_client.dart';

class WordRepository {

  final WordDatabaseClient _client = WordDatabaseClient();

  Future<List<Word>> fetchWords() async {
    return await this._client.fetchSavedWords();
  }

  Future<void> delete({Word word}) async {
    await this._client.delete(word: word);
  }

  Future<void> deleteAll() async {
    await this._client.deleteAll();
  }

  Future<void> insertWord({Word word}) async {
    await this._client.insert(data: word);
  }
}