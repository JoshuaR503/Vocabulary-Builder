import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'package:moblie/utils/colors.dart';
import 'package:moblie/utils/settings.dart';
import 'package:moblie/widgets/ui/divider.dart';
import 'package:moblie/widgets/ui/list_cell.dart';
import 'package:moblie/widgets/ui/text/subtitle.dart';
import 'package:moblie/widgets/ui/text/title.dart';

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
          child: ListView(
            children: <Widget>[

              CommonTitle('Aplicación desarrollada por Joshua García'),
              ListCell(
                title: ('Toca para contactar'),
                subtitle: ('El objetivo de esta aplicación es ayudar a aumentar el vocabulario de las peronas que estan aprendiendo Inglés, con una interfaz limpia y  sinpublicidad.'),
                onTap: () async => await FlutterWebBrowser.openWebPage(url: authorEmail, androidToolbarColor: primaryColor,),
              ),

              CommonTitle('Iconos Diseñados por mynamepong'),
              SubTitle('Toca en el icono para mas información'),
              ListCell(
                leading: Image.asset(
                  'assets/running-man.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono del hombre corriendo.'),
                subtitle: ('Toca en el icono para mas información'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/mynamepong'),
              ),

              CommonTitle('Iconos Diseñados por Freepik'),
              SubTitle('Toca en el icono para mas información'),
              ListCell(
                leading: Image.asset(
                  'assets/books.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono del libro.'),
                subtitle: ('Toca en el icono para mas información'),
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
                subtitle: ('Toca en el icono para mas información'),
                
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/freepik'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: Image.asset(
                  'assets/shield.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono del escudo.'),
                subtitle: ('Toca en el icono para mas información'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/freepik'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: Image.asset(
                  'assets/info.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono de pregunta.'),
                subtitle: ('Toca en el icono para mas información'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/freepik'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: Image.asset(
                  'assets/idea.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono del foco.'),
                subtitle: ('Toca en el icono para mas información'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/freepik'),
              ),
              Separator.divider(height: 0.0, indent: 74.0),
              ListCell(
                leading: Image.asset(
                  'assets/planet.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Diseñador del icono de Planeta.'),
                subtitle: ('Toca en el icono para mas información'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/freepik'),
              ),
            ]
          )
        )
      )
    );
  }
}