import 'package:equatable/equatable.dart';

abstract class WordsEvent extends Equatable {
  WordsEvent([List props = const []]) : super(props);
}

class FetchWords extends WordsEvent {}

class FetchMoreWords extends WordsEvent {}
