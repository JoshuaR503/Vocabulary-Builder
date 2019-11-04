import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';
import 'package:vocabulary_builder/v2/core/network.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/repositories.dart';
import './bloc.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {

  final WordsRepository _wordsRepository = WordsRepository();
  final NetworkInfoImpl _networkInfoImpl = NetworkInfoImpl();
  final VocabularyBuilderFunctions _functions = VocabularyBuilderFunctions();

  @override
  WordsState get initialState => WordsEmpty();

  @override
  Stream<WordsState> mapEventToState( WordsEvent event ) async* {

    // Fetch Words Event.
    if (event is FetchWords) {

      final bool isConnected = await _networkInfoImpl.isConnected;

      if (isConnected) {

        try {
          yield WordsLoading();

          final int wordCount = await _wordsRepository.fetchWordCount(category: event.categoryName);
          final int randomNumber = _functions.randonNumber(wordCount);
          
          final List<Word> words = event.category == 'All Words'
          ? await _wordsRepository.fetchWords(skip: randomNumber)
          : await _wordsRepository.fetchWordsFromCategory(category: event.category, skip: randomNumber);

          yield words.length == 0
          ? WordsZero()
          : WordsLoaded(words: words);

        } catch (e) {
          yield WordsError(error: e);
        }
      }

      if (!isConnected) {
        yield WordsNoConnection();  
      }

    }
  }
}
