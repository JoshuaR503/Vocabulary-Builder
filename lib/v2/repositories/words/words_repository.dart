
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/words/words_api_client.dart';

class WordsRepository {
  final WordsApiClient wordsApiClient = WordsApiClient();

  Future<List<Word>> fetchWords() async {
    return await wordsApiClient.fetchWords();
  }
}