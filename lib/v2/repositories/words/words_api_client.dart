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
  Future<List<Word>> fetchWords({int skip, Color forcedColor, bool random}) async {

    // Meta Data from Settings Repository.
    final Map<String, String> langMetaData = await settingsRepository.getUserLanguage();
    final String targetLang = langMetaData['targetLanguage'].toLowerCase();
    final String path = random ? kRandomPath : kStandardPath;

    // API Endpoint.
    final Uri uri = Uri.https(kBaseUri, path,{
      'skip': '0',
      'lang': targetLang
    });

    //Return Words.
    return this._fetchWords(
      uri: uri, 
      shouldHaveColor: false, 
      forcedColor: forcedColor
    );
  }

  /// Makes an HTTP request to the API endpoint set by [category].
  /// Returns a list of words from [category].
  Future<List<Word>> fetchWordsFromCategory(String category, int skip) async {
    // Meta Data from Settings Repository.
    final Map<String, String> langMetaData = await settingsRepository.getUserLanguage();
    final String targetLang = langMetaData['targetLanguage'].toLowerCase();

    // API Endpoint.
    final Uri uri = Uri.http(kBaseUri, '/v3/word/category/$category', {
      'skip': '0',
      'limit': '0',
      'language': targetLang
    });

    // Return Words.
    return this._fetchWords(
      uri: uri, 
      shouldHaveColor: true
    );
  }

  /// Makes an HTTP request to the API endpoint set by [category].
  /// Returns an integer with the count of words in the endpoint set by [category].
  Future<int> fetchWordCount({dynamic category}) async {
    
    // Ensure that category not null.
    final bool hasCategory = category == null;

    // Decide API endpoint.
    final Uri uri = hasCategory 
    ? Uri.http(kBaseUri, '/v2/word/count')               /// Count all words
    : Uri.http(kBaseUri, '/v2/word/count/category', {   /// Count all words from [category]
      'category': category
    });

    // Make HTTP Request
    final Response<dynamic> response = await this.httpClient.fetchData(uri: uri);    
    
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
  Future<List<Word>> _fetchWords({Uri uri, bool shouldHaveColor, Color forcedColor}) async {

    // User preferences stored.
    final Map<String, String> langMetaData = await settingsRepository.getUserLanguage();

    // Make HTTP Request.
    final Response<dynamic> response = await this.httpClient.fetchData(uri: uri);

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
