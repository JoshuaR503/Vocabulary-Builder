import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:vocabulary_builder/v2/blocs/config/bloc.dart';

import 'package:vocabulary_builder/v2/blocs/delegate.dart';
import 'package:vocabulary_builder/v2/blocs/search/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/theme/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/word/word_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';

import 'package:vocabulary_builder/v2/config/themes/themes.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';
import 'package:vocabulary_builder/v2/screens/language/language.dart';

import 'package:vocabulary_builder/v2/screens/screens.dart';

void main() async {

  BlocSupervisor.delegate = SimpleBlocDelegate();

  final SettingsRepository settingsRepository = SettingsRepository();
  final bool hasLanguage = await settingsRepository.hasCompleted(key: 'language');
  final bool hasLevel = await settingsRepository.hasCompleted(key: 'level');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          builder: (context) => ThemeBloc(),
        ),

        BlocProvider<WordsBloc>(
          builder: (context) => WordsBloc(),
        ),

        BlocProvider<WordBloc>(
          builder: (context) => WordBloc(),
        ),

        BlocProvider<SearchBloc>(
          builder: (context) => SearchBloc(),
        ),

        BlocProvider<ConfigBloc>(
          builder: (context) => ConfigBloc(
            hasLanguage: hasLanguage,
            hasLevel: hasLevel
          ),
        )
      ],
      child: VocabularyBuilderApp(),
    ),
  );
}

class VocabularyBuilderApp extends StatelessWidget {
  
  
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  final Map<String, WidgetBuilder> routes = {
    '/': (BuildContext context) => VocabularyBuilderHomeScreenManager(),
    '/home':  (BuildContext context) => Home(shouldAdLoad: false,),
    
    '/saved': (BuildContext context) => SavedWordsScreen(),
    '/settings': (BuildContext context) => SettingsScreen(),

    '/language': (BuildContext context) => LanguageScreen(),
    '/level': (BuildContext context) => LevelScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
          title: 'Vocabulary Builder',
          theme: appTheme['Dark'],
          routes: routes,

          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: _analytics),
          ],
          
          supportedLocales: [
            Locale('en', 'US'),
            Locale('es', 'US')
          ],

          localizationsDelegates: [
            FlutterI18nDelegate(false, 'en'),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
        );
      }
    );
  }
}