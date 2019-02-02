import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../widgets/palabras/palabras.dart';
import '../model/main.dart';
import '../utils/settings.dart';

class MainScreen extends StatefulWidget {
  
  final MainModel model;
  
  MainScreen(this.model);

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {

  @override
  initState() {
    widget.model.obtenerPalabras();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text(appname),
          ),
          ListTile(
            leading: Icon(Icons.bookmark_border),
            title: Text(savedSection),
            onTap: () => Navigator.pushNamed(context, '/saved')
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(settingsSection),
            onTap: () => Navigator.pushNamed(context, '/settings')
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(infoSection),
            onTap: () => Navigator.pushNamed(context, '/about')
          ),
          
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Comentarios'),
            onTap: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback)
            
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Contribuciones'),
            onTap: () => FlutterWebBrowser.openWebPage(url: urlSendContributions)
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {

        Widget content = Center(child: Text('No data found. :('));

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

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar( 
        title: Text(appname),
        centerTitle: true,
      ),
      body: _buildMainContent(),
    );
  }

}


