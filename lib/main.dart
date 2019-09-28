// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_i18n/flutter_i18n_delegate.dart';

// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';

// import 'package:vocabulary_builder/model/main.dart';
// import 'package:vocabulary_builder/pages/others/creditos-screen.dart';
// import 'package:vocabulary_builder/pages/others/help.dart';

// import 'package:vocabulary_builder/pages/palabra-guardada-screen.dart';
// import 'package:vocabulary_builder/pages/palabras-screen.dart';
// import 'package:vocabulary_builder/pages/screens/intro-screen.dart';
// import 'package:vocabulary_builder/pages/screens/welcome-screen.dart';

// import 'package:vocabulary_builder/utils/colors.dart';
// import 'package:vocabulary_builder/utils/settings.dart';

// import 'package:scoped_model/scoped_model.dart';
// import 'package:dynamic_theme/dynamic_theme.dart';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// final MainModel model = MainModel();
    
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vocabulary_builder/utils/settings.dart';

import 'package:vocabulary_builder/v2/screens/category/category.dart';
import 'package:vocabulary_builder/v2/screens/home/home.dart';

import 'package:vocabulary_builder/v2/themes/bloc/bloc.dart';
import 'package:vocabulary_builder/v2/themes/themes.dart';
import 'package:vocabulary_builder/v2/widgets/animations/route.dart';

void main() async {
  runApp( VocabularyBuilderApp());
}

class VocabularyBuilderApp extends StatelessWidget {

  Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return FadeRoute(page: Home());

      case "/nouns":
        return FadeRoute(page: Category());

      default:
        return null;
    }
  }

  Widget _build(BuildContext context, ThemeState state) {
    return MaterialApp(
      title: appname,
      theme: state.themeData,
      onGenerateRoute: _getRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _build,
      )
    );
  }
}