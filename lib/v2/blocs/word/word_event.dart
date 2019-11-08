import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

abstract class WordEvent extends Equatable {
  WordEvent([List props = const []]) : super(props);
}

class FetchWordsEvent extends WordEvent {}

class DeleteWordsEvent extends WordEvent {}

class DeleteWordEvent extends WordEvent {
  final Word word;

  DeleteWordEvent({
    @required this.word
  }) : super([word]);
}

class InsertWordEvent extends WordEvent {}