import 'package:flutter/material.dart';
import 'package:moblie/model/main.dart';
import 'package:moblie/pages/screens/error-screen.dart';
import 'package:moblie/utils/settings.dart';
import 'package:moblie/widgets/palabras/palabras.dart';
import 'package:moblie/widgets/ui/divider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:share/share.dart';

class PalabrasScreen extends StatefulWidget {
  
  final MainModel model;
  
  PalabrasScreen(this.model);

  @override
    State<StatefulWidget> createState() => _PalabrasScreenState();
}

class _PalabrasScreenState extends State<PalabrasScreen> {


  @override
  void initState() {
    widget.model.obtenerPalabras(loadingIndicator: true);
    super.initState();
  }
  
  Widget _buildMainContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {

        Widget content = ErrorScreen(
          message: FlutterI18n.translate(context, 'error_message.no_server_connection.message'),
          pathImage: 'assets/warning.png',
          fixMessage: FlutterI18n.translate(context, 'error_message.no_server_connection.solution'),
        );

        if (model.allPalabras.length > 0 && !model.isLoading) {
          content = Palabras();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: model.obtenerPalabras,
          child: content
        );
      }
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
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
          
          Separator.divider(),
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
            title: Text(FlutterI18n.translate(context, 'home.drawer.credits')),
            onTap: () => Navigator.pushNamed(context, '/creditos'),
          ),
        ],
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
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
      body: _buildMainContent(),
    );  
  }
}