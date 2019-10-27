import 'package:vocabulary_builder/v2/models/translation.dart';
import 'package:vocabulary_builder/v2/repositories/translation/translation_client.dart';

class TranslationRepository {
  final TranslationApiClient _client = TranslationApiClient();

  Future<String> translate({
    String sl, // Source Language.
    String tl, // Target Language.
    String text // Text to translate.
  }) async => await _client.translate(sl: sl, tl: tl, text: text);

  Future<List<Translation>> fetchSavedTranslations() async {
    return await this._client.fetchTranslations();  
  }

  Future<void> insert({Translation translation}) async {
    await this._client.insert(translation: translation);
  }

  Future<void> delete({Translation translation}) async {
    await this._client.delete(translation: translation);
  }
}