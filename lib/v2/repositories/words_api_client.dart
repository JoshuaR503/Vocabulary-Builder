
import 'package:dio/dio.dart';
import 'package:vocabulary_builder/v2/models/word.dart';

class WordsApiClient {

  static final String baseUrl = 'https://vocabulary-builder.herokuapp.com';
  final Dio httpClient = Dio();

  Future<List<Word>> fetchWords() async {

    final serverUrl = '$baseUrl/v3/word/public?limit=8';
    final serverResponse = await this.httpClient.get(serverUrl);

    if (serverResponse.statusCode != 200) {
      throw Exception('There was an error with the Server');
    }

    final dynamic dataJson = serverResponse.data;
    final List<Word> response = dataJson.response;

    return response;
  }
}