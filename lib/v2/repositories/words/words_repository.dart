
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/words/words_api_client.dart';

class WordsRepository {
  final WordsApiClient wordsApiClient = WordsApiClient();

  Future<int> fetchWordCount({dynamic category}) async {
    return await wordsApiClient.fetchWordCount(category: category);
  }

  Future<List<Word>> fetchWords({int skip}) async {
    return await wordsApiClient.fetchWords(skip);
  }

  Future<List<Word>> fetchWordsFromCategory({String category, int skip}) async {
    return await wordsApiClient.fetchWordsFromCategory(category, skip);
  }
}