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

    if (
      event is FetchWordsEvent || 
      event is InsertWordEvent
    ) {
      // Fetch words.
      yield* _fetchWords();

    } else if (event is DeleteWordEvent) {
      // Delete a word and then fetch them again.
      await _wordRepository.delete(word: event.word);
      yield* _fetchWords();

    } else if (event is DeleteWordsEvent) {
      // Delete all words.
      await _wordRepository.deleteAll();
      yield EmptyWordState();
    }
  }

  Stream<WordState> _fetchWords() async* {
    // Fetch words from Database.
    final List<Word> words = await _wordRepository.fetchWords();

    // Return error if words are null.
    if (words == null) {
      yield ErrorWordState();

    // Return words if they're found.
    } else if (words.isNotEmpty) {
      yield LoadedWordState(words: words);

    // Return empty screen if there are no words.
    } else {
      yield EmptyWordState();
    }
  }
}
