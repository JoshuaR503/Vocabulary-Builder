import 'package:flutter/material.dart';
import 'package:vocabulary_builder/model/main.dart';

import 'package:vocabulary_builder/pages/screens/error-screen.dart';
import 'package:vocabulary_builder/utils/settings.dart';

import 'package:vocabulary_builder/widgets/palabras/palabras.card.dart';
import 'package:vocabulary_builder/widgets/ui/divider.dart';
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
    widget.model.obtenerPalabras(loadingIndicator: true, lang: widget.model.userLang);
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

        final double deviceWidth = MediaQuery.of(context).size.width;
        final double targetWidth = deviceWidth > 768.0 ? 450.0 : deviceWidth;
        final Orientation orientation = MediaQuery.of(context).orientation;

        Widget content = ErrorScreen(
          pathImage: 'assets/warning.png',
          message: FlutterI18n.translate(context, 'error_message.no_server_connection.message'),
          fixMessage: FlutterI18n.translate(context, 'error_message.no_server_connection.solution'),
        );

        if (model.allPalabras.length > 0 && !model.isLoading) {
          content = orientation == Orientation.landscape 

          ? Center(
            child: Container(
              width: targetWidth,
              
              child: ListView.builder(
                itemCount: model.allPalabras.length,
                itemBuilder: (context, index) => 
                 Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: PalabraCard(model.allPalabras[index])
                )
              ),
            )
          )

          : ListView.builder(
            itemCount: model.allPalabras.length,
            itemBuilder: (context, index) => PalabraCard(model.allPalabras[index])
          );
           
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () => model.obtenerPalabras(loadingIndicator: false, lang: widget.model.userLang),
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