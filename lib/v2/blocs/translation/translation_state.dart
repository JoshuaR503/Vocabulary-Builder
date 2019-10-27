import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocabulary_builder/v2/models/translation.dart';

abstract class TranslationState extends Equatable {
  TranslationState([List props = const []]) : super(props);
}

class InitialTranslationState extends TranslationState {}

class EmptyTranslationState extends TranslationState {}

class LoadingTranslationState extends TranslationState {}

class LoaedTranslationState extends TranslationState {
  final String translation;

  LoaedTranslationState({
    @required this.translation
  })
    : assert(translation != null),
      super([translation]); 
}

class LoaedTranslationSavedState extends TranslationState {

  final List<Translation> translations;

  LoaedTranslationSavedState({
    @required this.translations
  })
    : assert(translations != null),
      super([translations]); 
}
