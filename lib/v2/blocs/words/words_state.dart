import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

abstract class WordsState extends Equatable {
  WordsState([List props = const []]) : super(props);
}

class WordsEmpty extends WordsState {}

class WordsLoading extends WordsState{}

class WordsLoaded extends WordsState {
  final List<Word> words;

  WordsLoaded({@required this.words})
    : assert(words != null),
      super([words]); 
}

class WordsError extends WordsState {
  final dynamic error;

  WordsError({@required this.error})
    : assert(error != null),
      super([error]); 
}

class WordsZero extends WordsState {}

class WordsTryAgain extends WordsState {}

class WordsNoConnection extends WordsState {}

class SectionNotAvailable extends WordsState {}