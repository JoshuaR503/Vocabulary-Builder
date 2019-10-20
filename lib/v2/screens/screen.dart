
import 'package:flutter/widgets.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';

import 'package:vocabulary_builder/v2/screens/home/home.dart';
import 'package:vocabulary_builder/v2/screens/intro/intro.dart';
import 'package:vocabulary_builder/v2/screens/language/language.dart';
import 'package:vocabulary_builder/v2/screens/level/level.dart';

class VocabularyBuilderHomeScreenManager extends StatelessWidget {

  Future<String> _futureBuilder() async {

    final SettingsRepository settingsRepository = SettingsRepository();
    final bool hasSeenSlider = await settingsRepository.hasCompleted(key: 'seen');
    final bool hasLanguage = await settingsRepository.hasCompleted(key: 'language');
    final bool hasLevel = await settingsRepository.hasCompleted(key: 'level');

    if (!hasSeenSlider) {
      return 'slider';
    }

    if (!hasLanguage) {
      return 'language';
    }

    if (!hasLevel) {
      return 'level';
    }

    return 'home';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureBuilder(),
      builder: (context, snapshot) {

        print(snapshot.data);

        if (snapshot.data == 'slider') {
          return IntroScreen();
        }

        if (snapshot.data == 'language') {
          return LanguageScreen();
        }

        if (snapshot.data == 'level') {
          return LevelScreen();
        }

        return Home();
      },
    );
  }
}

