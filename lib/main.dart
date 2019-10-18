// void main() {
//   model.loadData();
//   model.checkInternetConnection();

//     // Pass all uncaught errors to Crashlytics.
//     FlutterError.onError = Crashlytics.instance.recordFlutterError;

//     runZoned<Future<void>>(() async {
//       runApp(VocabularyBuilder());
//     }, onError: Crashlytics.instance.recordError);
//   }

// class VocabularyBuilder extends StatefulWidget {

//   @override
//   _VocabularyBuilderState createState() => _VocabularyBuilderState();
// }

// class _VocabularyBuilderState extends State<VocabularyBuilder> {

//   FirebaseAnalytics _analytics = FirebaseAnalytics();

//   ThemeData _buildTheme() => ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: primaryColor,
//     accentColor: accentColor,
//     canvasColor: backgroundColor,
//     cardColor: cardColor,
//     dialogBackgroundColor: cardColor,
//     dividerColor: dividerColor,
//     highlightColor: highlightColor
//   );

//   @override
//   Widget build(BuildContext context) {

//     return ScopedModel <MainModel> (
//       model: model,
//       child: DynamicTheme(
//         data: (brightness) => _buildTheme(),
//         themedWidgetBuilder: (context, theme) => MaterialApp(

//           navigatorObservers: [
//             FirebaseAnalyticsObserver(analytics: _analytics),
//           ],
//           supportedLocales: [
//             Locale('en', 'US'),
//             Locale('es', 'US')
//           ],
//           localizationsDelegates: [
//             FlutterI18nDelegate(false, 'en'),
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate
//           ],
        
//           theme: theme,
//           title: appname,
//           debugShowCheckedModeBanner: false,
//           routes: {
//             '/' : (BuildContext context) => model.seen 

//               ? PalabrasScreen(model) 
//               : model.userLang == null
//               ? WelcomeScreen()
//               : IntroScreen(),

//             '/home': (BuildContext context) => PalabrasScreen(model),
//             '/palabras': (BuildContext context) => PalabrasScreen(model),
//             '/saved': (BuildContext context) => PalabraGuardadaScreen(model),
//             '/creditos': (BuildContext context) => CreditoScreen(),
//             '/help': (BuildContext context) => Help(),
//             '/intro':  (BuildContext context) => IntroScreen(),
//             '/lang': (BuildContext context) => WelcomeScreen(),
//           },
//         ),
//       ),
//     ); 
//   }
// }



import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:vocabulary_builder/v2/blocs/delegate.dart';
import 'package:vocabulary_builder/v2/blocs/search/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/theme/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/word/word_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';
import 'package:vocabulary_builder/v2/config/themes/themes.dart';

import 'package:vocabulary_builder/v2/screens/intro/intro.dart';
import 'package:vocabulary_builder/v2/screens/saved/saved.dart';
import 'package:vocabulary_builder/v2/screens/screen.dart';
import 'package:vocabulary_builder/v2/screens/settings/settings.dart';
import 'package:vocabulary_builder/v2/screens/translator/translator.dart';

void main() async {

  BlocSupervisor.delegate = SimpleBlocDelegate();

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
    '/into': (BuildContext context) => IntroScreen(),
    '/saved': (BuildContext context) => SavedWordsScreen(),
    '/settings': (BuildContext context) => SettingsScreen(),
    '/translator': (BuildContext context) => TranslatorScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState state) {
        return MaterialApp(
          
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