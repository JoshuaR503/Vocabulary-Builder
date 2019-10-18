



import 'package:dio/dio.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

class SearchApiClient {

  static final String baseUrl = 'https://vocabulary-builder.herokuapp.com';
  final Dio httpClient = Dio();

  Future<List<Word>> searchWords({String search}) async {

    // Get Word Count.
    final String url = '$baseUrl/v1/search/en/?search=$search';

    // http request - words.
    final Response<dynamic> response = await this._fetchData(url: url);
  
    // Handle more status code responses.
    if (response.statusCode != 200) {
      throw Exception('There was an error with the Server.');
    }

    final data = response.data;
    final List<dynamic> wordsResponse = data['response'];
    final List<Word> words = Word.converToList(wordsResponse);
  
    return words;
  }

  Future<Response> _fetchData({String url}) async {
    final response = await this.httpClient.get(url);
    return response;
  }
}