import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:sentry/sentry.dart';

import './pages/palabra-guardada-screen.dart';
import './pages/others/about-screen.dart';
import './pages/others/settings-screen.dart';
import './pages/screens/intro-screen.dart';
import './pages/home-screen.dart';

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
    
    return ScopedModel <MainModel> (
      model: model,
      child: DynamicTheme(
        data: (brightness) => _buildTheme(),
        themedWidgetBuilder: (context, theme) => MaterialApp (
          theme: theme,
          title: appname,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (BuildContext context) => model.seen ? HomeScreen(model) : IntroScreen(model),
            '/home': (BuildContext context) => HomeScreen(model),
            '/saved': (BuildContext context) => PalabraGuardadaScreen(model),
            '/about':  (BuildContext context) => AboutScreen(),
            '/settings':  (BuildContext context) => SettingScreen(),
          }
        ),
      ),
    ); 
  }
}