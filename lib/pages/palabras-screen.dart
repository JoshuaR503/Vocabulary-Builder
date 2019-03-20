import 'package:flutter/material.dart';
import 'package:moblie/model/main.dart';

import 'package:moblie/pages/screens/error-screen.dart';
import 'package:moblie/utils/colors.dart';
import 'package:moblie/utils/settings.dart';

import 'package:moblie/widgets/palabras/palabras.card.dart';
import 'package:moblie/widgets/ui/divider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

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
      body: _buildMainContent()
    );
    //   floatingActionButton: FloatingActionButton(
    //     child: Icon(
    //       Icons.refresh,
    //     ),
    //     tooltip:  FlutterI18n.translate(context, 'home.appbar.icons.refresh_tooltip'),
    //     onPressed: () => widget.model.obtenerPalabras(loadingIndicator: true),
    //   ),
    // );  
  }
  
  Widget _buildMainContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {

        Widget content = ErrorScreen(
          pathImage: 'assets/warning.png',
          message: FlutterI18n.translate(context, 'error_message.no_server_connection.message'),
          fixMessage: FlutterI18n.translate(context, 'error_message.no_server_connection.solution'),
        );

        if (model.allPalabras.length > 0 && !model.isLoading) {

          // Create ListView for all Palabras
          content =  ListView.builder(
            itemCount: model.allPalabras.length,
            itemBuilder: (BuildContext context, int index) => 
              PalabraCard(model.allPalabras[index], model.userLang)
          );

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

          // ListTile(
          //   title: Text(FlutterI18n.translate(context, 'settings.title')),
          //   onTap: () => Navigator.pushNamed(context, '/settings'),
          // ),

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
}