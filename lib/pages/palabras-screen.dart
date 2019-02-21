import 'package:flutter/material.dart';
import 'package:moblie/model/main.dart';
import 'package:moblie/utils/settings.dart';
import 'package:moblie/widgets/palabras/palabras.dart';
import 'package:moblie/widgets/ui/divider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

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
            leading: Icon(FontAwesomeIcons.play),
            title: Text('Ver Introducción'),
            onTap: () => Navigator.pushNamed(context, '/intro'),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.solidQuestionCircle),
            title: Text('Preguntas Frecuentes'),
            onTap: () => Navigator.pushNamed(context, '/help'),
          ),

          Separator.divider(height: 0.0, indent: 74.0),
          ListTile(
            leading: Icon(FontAwesomeIcons.globeAmericas),
            title: Text('Versión web'),
            onTap: () => FlutterWebBrowser.openWebPage(url: webVersion)
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.comments),
            title: Text('Enviar comentarios'),
            onTap: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback)
          ),
          
          Separator.divider(height: 0.0, indent: 74.0),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Creditos'),
            onTap: () => Navigator.pushNamed(context, '/creditos'),
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