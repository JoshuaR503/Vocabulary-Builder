import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocabulary_builder/v2/models/translation.dart';

abstract class TranslationEvent extends Equatable {
  const TranslationEvent();
}

class TranslationText extends TranslationEvent {
  TranslationText({
    @required this.text,
    @required this.sl,
    @required this.tl
  }): assert (text != null);

  final String text;
  final String sl;
  final String tl;
}

class TranslationSave extends TranslationEvent {

  TranslationSave({
    @required this.translation
  }): assert (translation != null);

  final Translation translation;
}

class TranslationSaveFetch extends TranslationEvent { }