import 'package:shared_preferences/shared_preferences.dart';

class VocabularyBuilderSettingsClient {

  /// Store user language set by [language].
  void setUserLanguage({String language}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', language);
  }

  /// Store user language level set by [level].
  void setUserLevel({String level}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('level', level);
  }

  /// A helper to find out what settings the user has completed set by [key].
  Future<bool> hasCompleted({String key}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool hasCompleted = preferences.containsKey(key);

    return hasCompleted 
    ? true 
    : false;
  }

  /// A helper to find out if the user's language is Spanish.
  Future<bool> userLanguageIsSpanish() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String language = preferences.getString('language');

    return language == 'es'
    ? true
    : false;
  }

  /// Return Map with the user language.
  Future<Map<String, String>> getUserLanguage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String language = preferences.getString('language');

    // Keys.
    final String firstLanguage = language == 'en' ? 'ES' : 'EN';
    final String targetLanguage = language == 'en' ? 'EN' : 'ES';

    // Return language data.
    return {
      'selectedLang': language,
      'firstLanguage': firstLanguage,
      'targetLanguage': targetLanguage
    };
  }

  // Returns a String with the user's language level.
  Future<String> getUserLevel() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String level = preferences.getString('level');
    
    return level;
  }
}
