import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/models/translation.dart';
import 'package:vocabulary_builder/v2/repositories/translation/translation_repository.dart';
import './bloc.dart';

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {

  final TranslationRepository _translationRepository = TranslationRepository();

  @override
  TranslationState get initialState => InitialTranslationState();

  @override
  Stream<TranslationState> mapEventToState(TranslationEvent event) async* {

    if (event is TranslationText) {
      yield LoadingTranslationState();

      // Make http request.
      final String translation = await _translationRepository.translate(
        sl: event.sl,
        tl: event.tl,
        text: event.text
      );

      // Save response to local db.
      await _translationRepository.insert(translation: Translation(
        firstLanguage: event.text,
        firstLanguageCode: event.sl,

        secondLanguage: translation,
        secondLanguageCode: event.tl
      ));

      // Show response from server.
      
      yield* _fetch(translation: translation);
    }
  }

  Stream<TranslationState> _fetch({String translation}) async* {

    // Fetch translation from Database.
    final List<Translation> translations = await _translationRepository.fetchSavedTranslations();
    final bool translationIsNotEmpty = translations.isNotEmpty;

    // Set fetched translation in State.
    yield translationIsNotEmpty
    ? LoaedTranslationSavedState(
      translations: translations,
      translation: translation
    )
    : EmptyTranslationState();
  }
}
