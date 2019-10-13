import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

abstract class WordEvent extends Equatable {
  WordEvent([List props = const []]) : super(props);
}

class FetchWordsEvent extends WordEvent {}

class InsertWordEvent extends WordEvent {
  final Word word;

  InsertWordEvent({
    @required this.word
  }) : super([word]);
}