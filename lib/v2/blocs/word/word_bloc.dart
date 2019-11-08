import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/repositories.dart';
import './bloc.dart';

class WordBloc extends Bloc<WordEvent, WordState> {

  final WordRepository _wordRepository = WordRepository();

  @override
  WordState get initialState => InitialWordState();

  @override
  Stream<WordState> mapEventToState(WordEvent event) async* {

    if (event is FetchWordsEvent) {
      yield* _fetchWords();

    } else if (event is InsertWordEvent) {

      yield* _fetchWords();

    } else if (event is DeleteWordEvent) {
      await _wordRepository.delete(word: event.word);
      yield* _fetchWords();

    }  else if (event is DeleteWordsEvent) {

      await _wordRepository.deleteAll();
      yield* _fetchWords();
  
    }
  }

  Stream<WordState> _fetchWords() async* {
    // Fetch words from Database.
    final List<Word> words = await _wordRepository.fetchWords();

    if (words == null) {
      yield ErrorWordState();

    } else if (words.isNotEmpty) {
      yield LoadedWordState(words: words);

    } else {
      yield EmptyWordState();
    }
  }
}
