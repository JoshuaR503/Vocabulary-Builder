import 'package:vocabulary_builder/v2/repositories/settings/settings_client.dart';

class SettingsRepository {

  final VocabularyBuilderSettingsClient _client = VocabularyBuilderSettingsClient();

  void setUserLanguage({String language}) {
    _client.setUserLanguage(language: language);
  }

  void setUserLevel({String level}) {
    _client.setUserLevel(level: level);
  }

  void setUserSlider() {
    _client.setUserSlider();
  }

  Future<bool> hasCompleted({String key}) async {
    return await _client.hasCompleted(key: key);
  }

  Future<String> getUserLanguage() async {
    return await _client.getUserLanguage();
  }

  Future<String> getUserLevel() async {
    return await _client.getUserLevel();
  }
}
