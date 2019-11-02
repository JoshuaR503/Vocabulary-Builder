import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super(props);
}

class InitialSearchState extends SearchState {}

class LoadingSearchState extends SearchState {}

class LoadedSearchState extends SearchState {
  final List<Word> words;

  LoadedSearchState({@required this.words})
    : assert(words != null),
      super([words]); 
}

class ErrorSearchState extends SearchState {
  final error;

  ErrorSearchState({@required this.error})
    : assert(error != null),
      super([error]); 
}

class EmptySearchState extends SearchState {}

class SearchNoConnectionState extends SearchState {}
