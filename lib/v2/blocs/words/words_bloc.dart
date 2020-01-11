import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/core/network.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/repositories.dart';
import './bloc.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {

  final WordsRepository _wordsRepository = WordsRepository();
  final NetworkInfoImpl _networkInfoImpl = NetworkInfoImpl();
  // final SettingsRepository _settingsRepository = SettingsRepository();

  @override
  WordsState get initialState => WordsEmpty();

  @override
  Stream<WordsState> mapEventToState( WordsEvent event ) async* {

    if (event is FetchWords) {
      
      // Loading State.
      yield WordsLoading();

      // Ensure that there is Internet Connection.
      final bool isConnected = await _networkInfoImpl.isConnected;

      // Handler when there is no Internet Connection.
      if (!isConnected) {
        yield WordsNoConnection();  
      }

      try {
        // Words Response.
        final List<Word> words = await this.makeRequest(event.categoryName);
        // State handler.
        yield words.isEmpty 
        ? WordsError(error: 'Empty Results')
        : WordsLoaded(words: words);

      // Error Handling.
      } catch (e) {
        yield WordsError(error: e);
      }
    }
  }

  /// Makes an HTTP request and returns a list of words
  /// from the response of the API endpoint set by [category].
  Future<List<Word>> makeRequest(String category) async {

    // Category Type.
    final bool hasCategory = category == 'All Words';

    // List of Words.
    final List<Word> words = hasCategory
    ? await _wordsRepository.fetchWords(skip: 0)
    : await _wordsRepository.fetchWordsFromCategory(category: category, skip: 0);

    // Handler.
    if (words.isEmpty) {
      return this.makeRequest(category);
    } else {
      return words;
    }
  }
}
