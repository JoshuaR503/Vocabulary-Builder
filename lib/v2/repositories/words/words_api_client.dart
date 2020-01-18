import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/constants.dart';
import 'package:vocabulary_builder/v2/repositories/httpClient.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';

class WordsApiClient {

  // Settings Repository Class.
  final SettingsRepository settingsRepository = SettingsRepository();

  // HTTP Client.
  final FetchClient httpClient = FetchClient();

  /// Makes an HTTP request to the Words endpoint in the API.
  /// Returns a list of all words.
  Future<List<Word>> fetchWords(int skip, Color forcedColor) async {

    // Meta Data from Settings Repository.
    final Map<String, String> langMetaData = await settingsRepository.getUserLanguage();
    final String targetLang = langMetaData['targetLanguage'].toLowerCase();

    // API Endpoint. TODO: Change to URI
    final String url = '$kBaseUrl/v3/word/public?skip=0&lang=$targetLang';

    // Return Words.
    return this._fetchWords(url: url, shouldHaveColor: false, forcedColor: forcedColor);
  }

  /// Makes an HTTP request to the API endpoint set by [category].
  /// Returns a list of words from [category].
  Future<List<Word>> fetchWordsFromCategory(String category, int skip) async {

    // Meta Data from Settings Repository.
    final Map<String, String> langMetaData = await settingsRepository.getUserLanguage();
    final String targetLang = langMetaData['targetLanguage'].toLowerCase();

    // API Endpoint. TODO: Change to URI
    final String url = '$kBaseUrl/v3/word/category/$category?skip=0&limit=100&language=$targetLang';

    return this._fetchWords(url: url, shouldHaveColor: true);
  }

  /// Makes an HTTP request to the API endpoint set by [category].
  /// Returns an integer with the count of words in the endpoint set by [category].
  Future<int> fetchWordCount({dynamic category}) async {

    // Ensure that category is not null.
    final bool hasCategory = category != null;

    // Decide API endpoint.
    final String url = hasCategory 
    ? '$kBaseUrl/v2/word/count/category/?category=$category'
    : '$kBaseUrl/v2/word/count';

    // Make HTTP Request
    final Response<dynamic> response = await this.httpClient.fetchData(url: url);    
    
    // Handle other than 200 status code.
    if (response.statusCode != 200) {
      return 0;
    }

    // Handle data.
    final data = response.data;

    // Return data.
    return data['response'];
  }

  /// Makes an HTTP request to the API endpoint set by [url].
  /// Returns a list of words.
  Future<List<Word>> _fetchWords({String url, bool shouldHaveColor, Color forcedColor}) async {

    // User preferences stored.
    final Map<String, String> langMetaData = await settingsRepository.getUserLanguage();

    // Make HTTP Request.
    final Response<dynamic> response = await this.httpClient.fetchData(url: url);

    // Handle other than 200 status code.
    if (response.statusCode != 200 ) {
      throw Exception('There was an error with the Server');
    }
    
    // Handle data.
    final data = response.data;
    final List<dynamic> wordsResponse = data['response'];    
    final List<Word> words = Word.converToList(wordsResponse, langMetaData, shouldHaveColor, forcedColor);

    // Return Words.
    return words;
  }
}
