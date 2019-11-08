import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class WordsEvent extends Equatable {
  WordsEvent([List props = const []]) : super(props);
}

class FetchWords extends WordsEvent {

  final String category;
  final String categoryName;

  FetchWords({
    @required this.category,
    @required this.categoryName
  }) : super([category, categoryName]);
}

class FetchMoreWords extends WordsEvent {}
