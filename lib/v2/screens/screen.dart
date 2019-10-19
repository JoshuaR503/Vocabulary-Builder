
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/config/bloc.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';
import 'package:vocabulary_builder/v2/screens/home/home.dart';
import 'package:vocabulary_builder/v2/screens/language/language.dart';

class VocabularyBuilderHomeScreenManager extends StatelessWidget {

  final SettingsRepository settingsRepository = SettingsRepository();
  
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (BuildContext context, ConfigState state) {

        if (state.isFirstTime) {
          // Return Slider
        }

        if (!state.hasLanguage) {
          return LanguageScreen();
        }

        if (!state.hasLevel) {
          // Return level screen
        }
        
        return Home();
      }
    );
  }
}


