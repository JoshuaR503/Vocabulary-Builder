import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/repositories.dart';
import './bloc.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {

  final WordsRepository wordsRepository = WordsRepository();

  @override
  WordsState get initialState => WordsEmpty();

  @override
  Stream<WordsState> mapEventToState( WordsEvent event ) async* {

    // Fetch Words Event.
    if (event is FetchWords) {

      yield WordsLoading();

      try {

        if (event.category != 'All Words') {
          final List<Word> words = await wordsRepository.fetchWordsFromCategory(event.category);

          yield words.length == 0
          ? WordsZero()
          : WordsLoaded(words: words);
          
        } else {
          final List<Word> words = await wordsRepository.fetchWords();

          yield words.length == 0
          ? WordsZero()
          : WordsLoaded(words: words);
        }
        
      } catch (e) {
        yield WordsError(error: e);
      }
    }

  }
}
