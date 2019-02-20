import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:moblie/widgets/ui/text/subtitle.dart';
import 'package:moblie/widgets/ui/text/title.dart';

import '../../widgets/ui/list_cell.dart';
import '../../widgets/ui/divider.dart';

class CreditoScreen extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      return WillPopScope(

        onWillPop: () {
          Navigator.pop(context, true);
        },
        
        child: Scaffold(
          appBar: AppBar(
            title: Text('Creditos'),
            centerTitle: true,
          ),  
          body: Scrollbar(
            child: ListView(children: <Widget>[
              CommonTitle('Informacion extra'),
              SubTitle('El objetivo de esta app es aumentar el vocabulario de las peronas que estan aprendiendo ingles'),
              CommonTitle('Iconos Diseñados por Freepik'),
              SubTitle('Click en iconos para mas informacion'),
              ListCell(
                leading: Image.asset(
                  'assets/books.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono del libro y icono de la aplicación.'),
                subtitle: ('Click para mas informacion'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'www.flaticon.com'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: Image.asset(
                  'assets/heart.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono del corazón.'),
                subtitle: ('Click para mas informacion'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'www.flaticon.com'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: Image.asset(
                  'assets/shield.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono del escudo.'),
                subtitle: ('Click para mas informacion'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'www.flaticon.com'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: Image.asset(
                  'assets/api.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono de API.'),
                subtitle: ('Click para mas informacion'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'www.flaticon.com'),
              ),
              
            ])
          )
        )
      );
    }
}