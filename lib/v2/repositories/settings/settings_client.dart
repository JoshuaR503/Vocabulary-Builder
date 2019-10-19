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

  void setUserSlider() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('seen', true);
  }

  Future<bool> hasCompleted({String key}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool hasCompleted = preferences.containsKey(key);

    print('$key $hasCompleted');

    if (hasCompleted) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getUserLanguage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String language = preferences.getString('language');

    return language;
  }

  Future<String> getUserLevel() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String level = preferences.getString('level');

    return level;
  }
}
