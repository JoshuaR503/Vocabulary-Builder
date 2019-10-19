import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {

  ConfigBloc({
    @required this.isFirstTime,
    @required this.hasLanguage,
    @required this.hasLevel
  }) : assert(isFirstTime != null),
       assert(hasLanguage != null),
       assert(hasLevel != null);

  final bool isFirstTime;
  final bool hasLanguage;
  final bool hasLevel;

  @override
  ConfigState get initialState => ConfigState(
    isFirstTime: this.isFirstTime,
    hasLanguage: this.hasLanguage,
    hasLevel: this.hasLevel
  );

  @override
  Stream<ConfigState> mapEventToState(ConfigEvent event) async* {

    final SettingsRepository settingsRepository = SettingsRepository();

    if (event is LanguageChangedEvent) {
      settingsRepository.setUserLanguage(language: event.config);

      final bool isFirstTime = await settingsRepository.hasCompleted(key: 'seen');
      final bool hasLanguage = await settingsRepository.hasCompleted(key: 'language');
      final bool hasLevel = await settingsRepository.hasCompleted(key: 'level');

      yield ConfigState(
        isFirstTime: isFirstTime,
        hasLevel: hasLevel,
        hasLanguage: hasLanguage,
      );
      
    } else if (event is LevelChangedEvent) {
      settingsRepository.setUserLevel(level: event.config);

      final bool isFirstTime = await settingsRepository.hasCompleted(key: 'seen');
      final bool hasLanguage = await settingsRepository.hasCompleted(key: 'language');
      final bool hasLevel = await settingsRepository.hasCompleted(key: 'level');

      yield ConfigState(
        isFirstTime: isFirstTime,
        hasLanguage: hasLanguage,
        hasLevel: hasLevel
      );
    }
  }
}
