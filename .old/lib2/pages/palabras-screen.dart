import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../widgets/palabras/palabras.dart';
import '../utils/settings.dart';
import '../model/main.dart';

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

        Widget content = Center(child: Text(onServerConnection));

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
            title: Text('Opciones'),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(infoSection),
            onTap: () => Navigator.pushNamed(context, '/about'),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Creditos'),
            onTap: () => Navigator.pushNamed(context, '/creditos'),
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Enviar comentarios'),
            onTap: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback, androidToolbarColor: Colors.deepPurple)
          ),
        ],
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: _buildDrawer(),
        appBar: AppBar(
          title: Text(appname),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () => Navigator.pushNamed(context, '/saved')
            )
          ],
        ),
        body: _buildMainContent(),
    );
  }
}