import 'package:equatable/equatable.dart';

abstract class WordEvent extends Equatable {
  WordEvent([List props = const []]) : super(props);
}

class FetchWordsEvent extends WordEvent {}
