import 'package:dio/dio.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

class WordsApiClient {

  static final String baseUrl = 'https://vocabulary-builder.herokuapp.com';
  final Dio httpClient = Dio();

  Future<List<Word>> fetchWords(int skip) async {

    final String url = '$baseUrl/v3/word/public?skip=$skip';

    // http request - words.
    final Response<dynamic> response = await this._fetchData(url: url);
  
    // Handle more status code responses.
    if (response.statusCode != 200) {
      throw Exception('There was an error with the Server');
    }

    final data = response.data;
    final List<dynamic> wordsResponse = data['response'];
    final List<Word> words = Word.converToList(wordsResponse);
  
    return words;
  }

  Future<List<Word>> fetchWordsFromCategory(String category, int skip) async {

    final String serverUrl = '$baseUrl/v3/word/category/$category?skip=$skip';
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

  Future<int> fetchWordCount({dynamic category}) async {

    final bool hasCategory = category != null;
    final String serverUrl = hasCategory 
    ? '$baseUrl/v2/word/count/category/?category=$category'
    : '$baseUrl/v2/word/count';

    final Response<dynamic> serverResponse = await _fetchData(url: serverUrl);
    final dynamic data = serverResponse.data;

    if (serverResponse.statusCode != 200) {
      return 0;
    }

    return data['response'];
  }

  Future<Response> _fetchData({String url}) async {
    final response = await this.httpClient.get(url);
    return response;
  }
}