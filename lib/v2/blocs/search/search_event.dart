import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super(props);
}

class SearchWordsEvent extends SearchEvent {

  final String query;

  SearchWordsEvent({@required this.query}) : super([query]);
}