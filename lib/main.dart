import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:moblie/model/main.dart';
import 'package:moblie/pages/others/creditos-screen.dart';
import 'package:moblie/pages/others/help-screen.dart';
import 'package:moblie/pages/others/question-screen.dart';
import 'package:moblie/pages/palabra-guardada-screen.dart';
import 'package:moblie/pages/palabras-screen.dart';
import 'package:moblie/pages/screens/intro-screen.dart';
import 'package:moblie/utils/colors.dart';
import 'package:moblie/utils/settings.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:sentry/sentry.dart';

void main() =>
  SystemChrome
  .setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_) => runApp(AmericanEnglishWords()));

class AmericanEnglishWords extends StatefulWidget {

  final SentryClient sentry = SentryClient(dsn: 'https://6fde3857a1bc4a33be3f1e79ae947b3f@sentry.io/1390352');

  @override
  _AmericanEnglishWordsState createState() => _AmericanEnglishWordsState();
}

class _AmericanEnglishWordsState extends State<AmericanEnglishWords> {

  ThemeData _buildTheme() => ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    accentColor: accentColor,
    canvasColor: backgroundColor,
    cardColor: cardColor,
    dialogBackgroundColor: cardColor,
    dividerColor: dividerColor,
    highlightColor: highlightColor
  );

  @override
  Widget build(BuildContext context) {
    
    final MainModel model = MainModel();
    model.obtenerData();
    
    return ScopedModel <MainModel> (
      model: model,
      child: DynamicTheme(
        data: (brightness) => _buildTheme(),
        themedWidgetBuilder: (context, theme) => MaterialApp (
          theme: theme,
          title: appname,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (BuildContext context) => model.seen ? PalabrasScreen(model) : IntroScreen(model),
            '/home': (BuildContext context) => PalabrasScreen(model),
            '/saved': (BuildContext context) => PalabraGuardadaScreen(model),
            '/creditos':  (BuildContext context) => CreditoScreen(),
            '/question':  (BuildContext context) => QuestionScreen(),
            '/help':  (BuildContext context) => HelpScreen(),
            '/intro':  (BuildContext context) => IntroScreen(model),
          }
        ),
      ),
    ); 
  }
}