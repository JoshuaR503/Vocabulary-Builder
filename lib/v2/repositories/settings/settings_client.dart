import 'package:shared_preferences/shared_preferences.dart';

class VocabularyBuilderSettingsClient {

  void setUserLanguage({String language}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', language);
  }

  void setUserLevel({String level}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('level', level);
  }

  Future<bool> hasCompleted({String key}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool hasCompleted = preferences.containsKey(key);

    if (hasCompleted) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, String>> getUserLanguage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String language = preferences.getString('language');

    // If learning lang is Spanish, then second lang will be English
    if (language == 'es') {
      return {
        'selectedLang': language,
        'firstLanguage': 'EN',
        'targetLanguage': 'ES'
      };
    }

    return {
      'selectedLang': language,
      'firstLanguage': 'ES',
      'targetLanguage': 'EN'
    };
  }

  Future<bool> userLanguageIsSpanish() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String language = preferences.getString('language');

    if (language == 'es') {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getUserLevel() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String level = preferences.getString('level');

    return level;
  }
}
