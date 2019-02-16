import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:sentry/sentry.dart';

import './pages/palabras-screen.dart';
import './pages/palabra-guardada-screen.dart';
import './pages/about-screen.dart';
import './pages/settings-screen.dart';

import './model/main.dart';
import './utils/colors.dart';
import './utils/settings.dart';

void main() => runApp(new LexiaHome());

class LexiaHome extends StatefulWidget {

  final SentryClient sentry = new SentryClient(dsn: 'https://6fde3857a1bc4a33be3f1e79ae947b3f@sentry.io/1390352');

  @override
  _LexiaHomeState createState() => new _LexiaHomeState();
}

class _LexiaHomeState extends State<LexiaHome> {

  ThemeData _buildTheme(Brightness brightness) {

    return brightness == Brightness.dark
      ? ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        accentColor: accentColor,
        canvasColor: backgroundColor,
        cardColor: cardColor,
        dialogBackgroundColor: cardColor,
        dividerColor: dividerColor,
        highlightColor: highlightColor
      )
      : ThemeData(  
        brightness: Brightness.light,           
        primaryColor: primaryLightColor,             
        accentColor: accentLightColor,               
        canvasColor: backgroundLightColor,           
        cardColor: cardLightColor,                   
        dialogBackgroundColor: cardColor,       
        dividerColor: dividerColor,             
        highlightColor: highlightColor          
      );
  }

  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    
    return ScopedModel <MainModel> (
      model: model,
      child: DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => _buildTheme(brightness),
        themedWidgetBuilder: (context, theme) => MaterialApp (
          theme: theme,
          title: appname,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (BuildContext context) => PalabrasScreen(model),
            '/saved': (BuildContext context) => PalabraGuardadaScreen(model),
            '/about':  (BuildContext context) => AboutScreen(),
            '/settings':  (BuildContext context) => SettingScreen(),
          }
        ),
      ),
    ); 
  }
}