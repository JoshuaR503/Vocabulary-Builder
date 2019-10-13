import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/repositories.dart';
import './bloc.dart';

class WordBloc extends Bloc<WordEvent, WordState> {

  WordRepository _wordRepository = WordRepository();

  @override
  WordState get initialState => InitialWordState();

  @override
  Stream<WordState> mapEventToState(WordEvent event) async* {

    if (event is FetchWordsEvent) {

      yield LoadingWordState();

      final List<Word> words = await _wordRepository.fetchWords();

      yield words.length > 0 
      ? LoadedWordState(words: words)
      : EmptyWordState();
    }
  }
}
