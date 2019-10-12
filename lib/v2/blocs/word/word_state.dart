import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

abstract class WordState extends Equatable {
  WordState([List props = const []]) : super(props);
}

class InitialWordState extends WordState {}

class LoadingWordState extends WordState {}

class LoadedWordState extends WordState {

  final List<Word> words;

  LoadedWordState({@required this.words})
    : assert(words != null),
      super([words]); 
}

class ErrorWordState extends WordState {}

class EmptyWordState extends WordState {}