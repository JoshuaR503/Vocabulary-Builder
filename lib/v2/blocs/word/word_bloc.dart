import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  @override
  WordState get initialState => InitialWordState();

  @override
  Stream<WordState> mapEventToState(WordEvent event) async* {


    if (event is FetchWordsEvent) {

      yield LoadingWordState();

      await Future
      .delayed(Duration(seconds: 5));

      yield EmptyWordState();
      
    }
  }
}
