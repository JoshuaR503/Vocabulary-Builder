import 'dart:math';
import 'package:dio/dio.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

class WordsApiClient {

  static final String baseUrl = 'https://vocabulary-builder.herokuapp.com';
  final Dio httpClient = Dio();

  Future<List<Word>> fetchWords() async {

    // Get Word Count.
    final int wordCount = await this._fetchWordCount();
    final int skip = wordCount != 0 ? wordCount : 0;
    final String url = '$baseUrl/v3/word/public';

    // http request - words.
    final Response<dynamic> response = await this._fetchData(url: url);
  
    // Handle more status code responses.
    if (response.statusCode != 200 || skip == 0) {
      throw Exception('There was an error with the Server');
    }

    final data = response.data;
    final List<dynamic> wordsResponse = data['response'];
    final List<Word> words = Word.converToList(wordsResponse);
  
    return words;
  }

  Future<List<Word>> fetchWordsFromCategory(String category) async {

    // Get Word Count.
    final int wordCount = await this._fetchWordCount();
    final int skip = wordCount != 0 ? wordCount : 0;

    final String serverUrl = '$baseUrl/v3/word/category/$category';
    final Response<dynamic> response = await _fetchData(url: serverUrl);

    // Handle more status code responses.
    if (response.statusCode != 200 ) {
      throw Exception('There was an error with the Server');
    }

    final data = response.data;

    final List<dynamic> wordsResponse = data['response'];
    final List<Word> words = Word.converToList(wordsResponse);

    return words;
  }

  Future<int> _fetchWordCount() async {
    final String serverUrl = '$baseUrl/v2/word/count';
    final Response<dynamic> serverResponse = await _fetchData(url: serverUrl);
    final dynamic data = serverResponse.data;

    if (serverResponse.statusCode != 200) {
      return 0;
    }
  
    final int max = data['response'];
    final int skip = _randomNumber(max);

    return skip;
  }

  Future<Response> _fetchData({String url}) async {
    final response = await this.httpClient.get(url);
    return response;
  }

  int _randomNumber(int max) {

    final Random random = Random();
    final int min = 1;
    final int skip = random.nextInt(max - min);

    return skip;
  }
}