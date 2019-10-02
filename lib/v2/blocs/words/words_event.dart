import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class WordsEvent extends Equatable {
  WordsEvent([List props = const []]) : super(props);
}

class FetchWords extends WordsEvent {

  final String category;

  FetchWords({@required this.category}) : super([category]);
}

class FetchMoreWords extends WordsEvent {}
