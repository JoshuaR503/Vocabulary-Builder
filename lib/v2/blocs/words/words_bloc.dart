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

    // Fetch Words Event.
    if (event is FetchWords) {

      yield WordsLoading();

      final bool isConnected = await _networkInfoImpl.isConnected;

      if (!isConnected) {
        yield WordsNoConnection();  
      }

      try {
        
        final List<Word> words = await makeRequest(event.categoryName);
      
        if (words.isNotEmpty) {
          yield WordsLoaded(words: words);
        } else {
          yield WordsError(error: 'x');
        }

      } catch (e) {
        yield WordsError(error: e);
      }
    }
  }

  Future<List<Word>> makeRequest(String category) async {

    final List<Word> words = await request(category);

    if (words.isEmpty) {
      return await request(category);
    }

    return words;
  }

  Future<List<Word>> request(String category) async {
    final List<Word> words = category == 'All Words'
    ? await _wordsRepository.fetchWords(skip: 0)
    : await _wordsRepository.fetchWordsFromCategory(category: category, skip: 0);
    
    return words;
  }
}
