import 'package:dio/dio.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/constants.dart';
import 'package:vocabulary_builder/v2/repositories/httpClient.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';

class SearchApiClient {

  // Settings Repository Class.
  final SettingsRepository settingsRepository = SettingsRepository();

  // HTTP Client.
  final FetchClient httpClient = FetchClient();

  //// Makes an HTTP request to the Search endpoint 
  /// in the API and returns words matching [search].
  Future<List<Word>> searchWords({String search}) async {

    // Meta Data from Settings Repository.
    final Map<String, String> langMetaData = await settingsRepository.getUserLanguage();

    // API Endpoint.
    final Uri uri = Uri.http(kBaseUri, '/v1/search/en/', {'search': search});

    // Make HTTP Request
    final Response<dynamic> response = await this.httpClient.fetchData(uri: uri);
  
    // Handle other than 200 status code.
    if (response.statusCode != 200) {
      throw Exception('There was an error with the Server.');
    }

    // Handle data.
    final data = response.data;
    final List<dynamic> wordsResponse = data['response'];
    final List<Word> words = Word.converToList(wordsResponse, langMetaData, true, AppColors.purple);
  
    // Return Words.
    return words;
  }
}