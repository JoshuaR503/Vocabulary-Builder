
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/config/bloc.dart';

import 'package:vocabulary_builder/v2/screens/home/home.dart';
import 'package:vocabulary_builder/v2/screens/language/language.dart';
import 'package:vocabulary_builder/v2/screens/level/level.dart';

class VocabularyBuilderHomeScreenManager extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (BuildContext context, ConfigState state) {

        if (!state.hasLanguage) {
          return LanguageScreen();
        } else if (!state.hasLevel) {
          return LevelScreen();
        }
        
        return Home();
      }
    );
  }
}

