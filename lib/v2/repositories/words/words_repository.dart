
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/words/words_api_client.dart';

class WordsRepository {

  // Words Client.
  final WordsApiClient _client = WordsApiClient();

  // Fetch word count.
  Future<int> fetchWordCount({dynamic category}) async {
    return await _client.fetchWordCount(category: category);
  }

  // Fetch all words.
  Future<List<Word>> fetchWords({int skip, Color forcedColor, bool random}) async {
    return await _client.fetchWords(
      skip: skip,
      random: random,
      forcedColor: forcedColor,
    );
  }

  // Fetch words from a single category.
  Future<List<Word>> fetchWordsFromCategory({String category, int skip}) async {
    return await _client.fetchWordsFromCategory(category, skip);
  }
}