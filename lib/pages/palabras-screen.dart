import 'package:flutter/material.dart';
import 'package:vocabulary_builder/model/main.dart';

import 'package:vocabulary_builder/pages/screens/error-screen.dart';
import 'package:vocabulary_builder/utils/settings.dart';

import 'package:vocabulary_builder/widgets/palabras/palabras.card.dart';
import 'package:vocabulary_builder/widgets/ui/divider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:share/share.dart';

class PalabrasScreen extends StatefulWidget {
  
  final MainModel model;
  
  PalabrasScreen(this.model);

  @override
  State<StatefulWidget> createState() => _PalabrasScreenState();
}

class _PalabrasScreenState extends State<PalabrasScreen> {

  InterstitialAd _beautifulAd = InterstitialAd(
    adUnitId: 'ca-app-pub-2366031658994135/7657028085',
    targetingInfo: MobileAdTargetingInfo(
      keywords: <String>['english', 'learning'],
      childDirected: false,
    ),
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  @override
  void initState() {
    widget.model.obtenerPalabras(loadingIndicator: true);
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-2366031658994135~3587559242');
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    // _beautifulAd
    // ..load()
    // ..show();

    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'home.title')),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[

          Tooltip(
            message: FlutterI18n.translate(context, 'home.appbar.icons.refresh_tooltip'),
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => widget.model.obtenerPalabras(loadingIndicator: true)
            ),
          ),
          
          Tooltip(
            message: FlutterI18n.translate(context, 'home.appbar.icons.heart_tooltip'),
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => Navigator.pushNamed(context, '/saved')
            ),
          )
        ],
      ),
      body: _buildMainContent()
    );
  }
  
  Widget _buildMainContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {

        Widget content;

        if (model.allPalabras.length > 0 && !model.isLoading) {
          content = ListView.builder(
            itemCount: model.allPalabras.length,
            itemBuilder: (context, index) => PalabraCard(model.allPalabras[index])
          );
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        } else {
          content = ErrorScreen(
            pathImage: 'assets/warning.png',
            message: FlutterI18n.translate(context, 'error_message.no_server_connection.message'),
            fixMessage: FlutterI18n.translate(context, 'error_message.no_server_connection.solution'),
          );
        }

        return RefreshIndicator(
          onRefresh: () => model.obtenerPalabras(loadingIndicator: false),
          child: content
        );
      }
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text(FlutterI18n.translate(context, 'home.drawer.title')),
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'question_answers.title')),
            onTap: () => Navigator.pushNamed(context, '/question'),
          ),

          ListTile(
            title: Text(FlutterI18n.translate(context, 'troubleshooting.title')),
            onTap: () => Navigator.pushNamed(context, '/help'),
          ),

          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.drawer.thidItem')),
            onTap: () => Share.share(shareApp)
          ),

          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.drawer.credits')),
            onTap: () => Navigator.pushNamed(context, '/creditos'),
          ),
          
          Separator.divider(),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.drawer.language')),
            onTap: () => Navigator.pushNamed(context, '/lang'),
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.drawer.web_version')),
            onTap: () => FlutterWebBrowser.openWebPage(url: webVersion)
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.drawer.web_feedback')),
            onTap: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback)
          ),
          
          Separator.divider(),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.drawer.show_slide')),
            onTap: () => Navigator.pushNamed(context, '/intro'),
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.drawer.privacy')),
            onTap: () => FlutterWebBrowser.openWebPage(url: urlConditions)
          ),
          ListTile(
            title: Text(FlutterI18n.translate(context, 'home.drawer.terms')),
            onTap: () => FlutterWebBrowser.openWebPage(url: urlTerms)
          ),
        ],
      ),
    );
  }
}