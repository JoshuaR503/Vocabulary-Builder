import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';
import 'package:vocabulary_builder/v2/core/network.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/repositories.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';
import './bloc.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {

  final WordsRepository _wordsRepository = WordsRepository();
  final NetworkInfoImpl _networkInfoImpl = NetworkInfoImpl();
  final VocabularyBuilderFunctions _functions = VocabularyBuilderFunctions();
  final SettingsRepository _settingsRepository = SettingsRepository();

  @override
  WordsState get initialState => WordsEmpty();

  @override
  Stream<WordsState> mapEventToState( WordsEvent event ) async* {

    // Fetch Words Event.
    if (event is FetchWords) {

      yield WordsLoading();

      final bool isConnected = await _networkInfoImpl.isConnected;
      final bool isSpanish = await _settingsRepository.userLanguageIsSpanish();

      if (!isConnected) {
        yield WordsNoConnection();  
      }

      if (isConnected) {
        try {
          final int wordCount = await _wordsRepository.fetchWordCount(category: event.categoryName);
          final int randomNumber = _functions.randonNumber(wordCount);
          
          final List<Word> words = event.category == 'All Words'
          ? await _wordsRepository.fetchWords(skip: randomNumber)
          : await _wordsRepository.fetchWordsFromCategory(category: event.category, skip: randomNumber);

          if (event.category == 'phrasal_verbs' && isSpanish) {
            yield SectionNotAvailable();
          } 
          
          else if (words.isEmpty) {
            yield WordsZero();
          } 
          
          else {
            yield WordsLoaded(words: words);
          }
        } catch (e) {
          yield WordsError(error: e);
        }
      }
      
    }
  }
}
