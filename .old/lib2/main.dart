import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sentry/sentry.dart';

import './pages/palabras-screen.dart';
import './pages/palabra-guardada-screen.dart';
import './pages/others/about-screen.dart';
import './pages/others/creditos-screen.dart';
import './pages/screens/intro-screen.dart';

import './model/main.dart';
import './utils/colors.dart';
import './utils/settings.dart';

void main() => runApp(new AmericanEnglishWords());

class AmericanEnglishWords extends StatefulWidget {

  final SentryClient sentry = new SentryClient(dsn: 'https://6fde3857a1bc4a33be3f1e79ae947b3f@sentry.io/1390352');

  @override
  _AmericanEnglishWordsState createState() => new _AmericanEnglishWordsState();
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
    
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp (
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        title: appname,
        routes: {
          '/': (BuildContext context) => model.seen == true ? PalabrasScreen(model) : IntroScreen(model),
          '/home': (BuildContext context) => PalabrasScreen(model),
          '/saved': (BuildContext context) => PalabraGuardadaScreen(model),
          '/about':  (BuildContext context) => AboutScreen(),
          '/creditos':  (BuildContext context) => CreditoScreen(),
        }
      ),
    ); 
  }
}