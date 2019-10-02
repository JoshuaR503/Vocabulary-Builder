
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
  
    // http request - words.
    final Response<dynamic> response = await this._fetchWords(skip);

    // Handle more status code responses.
    if (response.statusCode != 200 || skip == 0) {
      throw Exception('There was an error with the Server');
    }

    final data = response.data;
    final List<dynamic> wordsResponse = data['response'];
    final List<Word> words = Word.converToList(wordsResponse);
  
    return words;
  }

  Future<int> _fetchWordCount() async {

    final String serverUrl = '$baseUrl/v2/word/count';
    final Response<dynamic> serverResponse = await this.httpClient.get(serverUrl);

    if (serverResponse.statusCode != 200) {
      return 0;
    }

    final Random random = Random();
    final dynamic data = serverResponse.data;
    
    final int max = data['response'];
    final int min = 1;
    final int skip = random.nextInt(max - min);

    return skip;
  }

  Future<Response> _fetchWords(int skip) async {
    final serverUrl = '$baseUrl/v3/word/public?limit=8&skip=$skip';
    final serverResponse = await this.httpClient.get(serverUrl);

    return serverResponse;
  }
}