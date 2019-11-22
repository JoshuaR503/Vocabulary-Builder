import 'package:dio/dio.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';

class SearchApiClient {

  static final String baseUrl = 'https://vocabulary-builder.herokuapp.com';
  
  final SettingsRepository settingsRepository = SettingsRepository();
  final Dio httpClient = Dio();

  Future<List<Word>> searchWords({String search}) async {

    final Map<String, String> langMetaData = await settingsRepository.getUserLanguage();

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
    final List<Word> words = Word.converToList(wordsResponse, langMetaData, false);
  
    return words;
  }

  Future<Response> _fetchData({String url}) async {
    final response = await this.httpClient.get(url);
    return response;
  }
}