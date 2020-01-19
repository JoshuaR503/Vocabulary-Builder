
import 'package:flutter/widgets.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';

import 'package:vocabulary_builder/v2/screens/home/home.dart';
import 'package:vocabulary_builder/v2/screens/language/language.dart';
import 'package:vocabulary_builder/v2/screens/level/level.dart';

class VocabularyBuilderHomeScreenManager extends StatelessWidget {

  Future<String> _futureBuilder() async {

    final SettingsRepository settingsRepository = SettingsRepository();
    final bool hasLanguage = await settingsRepository.hasCompleted(key: 'language');
    final bool hasLevel = await settingsRepository.hasCompleted(key: 'level');

    Future.delayed(Duration(milliseconds: 2));

    if (!hasLanguage) {
      return 'language';
    }

    // if (!hasLevel) {
    //   return 'level';
    // }

    if (hasLanguage && hasLevel) {
      return 'home_ad';
    }

    return 'home';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureBuilder(),
      builder: (context, snapshot) {
        
        if (snapshot.data == 'language') {
          return LanguageScreen();
        }

        if (snapshot.data == 'level') {
          return LevelScreen();
        }

        if (snapshot.data == 'home_ad') {
          return Home(shouldAdLoad: true);
        }

        return Home(shouldAdLoad: false);
      },
    );
  }
}

