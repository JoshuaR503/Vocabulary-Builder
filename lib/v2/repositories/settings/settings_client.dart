


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

  void getUserLanguage() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString('language');
  }

  void getUserLevel() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString('level');
  }

}