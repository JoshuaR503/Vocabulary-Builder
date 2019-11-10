import 'package:vocabulary_builder/v2/repositories/settings/settings_client.dart';

class SettingsRepository {

  final VocabularyBuilderSettingsClient _client = VocabularyBuilderSettingsClient();

  void setUserLanguage({String language}) {
    _client.setUserLanguage(language: language);
  }

  void setUserLevel({String level}) {
    _client.setUserLevel(level: level);
  }

  Future<bool> hasCompleted({String key}) async {
    return await _client.hasCompleted(key: key);
  }

  Future<bool> userLanguageIsSpanish() async {
    return await _client.userLanguageIsSpanish();
  }

  Future<Map<String, String>> getUserLanguage() async {
    return await _client.getUserLanguage();
  }

  Future<String> getUserLevel() async {
    return await _client.getUserLevel();
  }
}
