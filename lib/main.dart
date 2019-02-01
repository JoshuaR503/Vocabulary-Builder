import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/main.dart';
import './pages/saved.dart';
import './pages/about.dart';
import './pages/settings.dart';

import './model/main.dart';
import './utils/colors.dart';
import './utils/settings.dart';

void main() => runApp(new LexiaHome());

class LexiaHome extends StatefulWidget {
  @override
    _LexiaHomeState createState() => new _LexiaHomeState();
}

class _LexiaHomeState extends State<LexiaHome> with SingleTickerProviderStateMixin {

  ThemeData _renderThemeData() => ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    accentColor: accentColor,
    canvasColor: backgroundColor,
    cardColor: cardColor,
    dialogBackgroundColor: cardColor,
    dividerColor: dividerColor,
    highlightColor: highlightColor,
  );

  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();

    return ScopedModel <MainModel> (
      model: model,
      child: MaterialApp(
        title: appname,
        debugShowCheckedModeBanner: false,
        theme: _renderThemeData(),
        routes: {
          '/': (BuildContext context) => MainScreen(model),
          '/saved': (BuildContext context) => SavedScreen(),
          '/settings': (BuildContext context) => SettingsScreen(),
          '/about':  (BuildContext context) => AboutScreen(),
        }
      ),
    ); 
    
  }
}

