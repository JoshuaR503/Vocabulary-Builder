import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocabulary_builder/v2/models/translation.dart';

abstract class TranslationState extends Equatable {
  TranslationState([List props = const []]) : super(props);
}

class InitialTranslationState extends TranslationState {}

class EmptyTranslationState extends TranslationState {}

class LoadingTranslationState extends TranslationState {}

class LoaedTranslationSavedState extends TranslationState {

  final List<Translation> translations;
  final String translation;

  LoaedTranslationSavedState({
    @required this.translations,
    @required this.translation
  })
    : assert(translations != null),
      assert(translation != null),
      super([translations, translation]); 
}
