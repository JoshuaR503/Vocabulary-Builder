import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:vocabulary_builder/v2/models/word.dart';
import 'package:vocabulary_builder/v2/repositories/words_repository.dart';
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
        final List<Word> words = await wordsRepository.fetchWords();
        yield WordsLoaded(words: words); 
      } catch (e) {
        yield WordsError();
      }
    }

  }
}
