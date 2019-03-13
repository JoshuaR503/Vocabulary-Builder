import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'package:moblie/utils/settings.dart';
import 'package:moblie/widgets/ui/list_cell.dart';
import 'package:moblie/widgets/ui/text/subtitle.dart';
import 'package:moblie/widgets/ui/text/title.dart';

class CreditoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              subtitle: ('El objetivo de esta aplicación es ayudar a aumentar el vocabulario de las peronas que estan aprendiendo Inglés, con una interfazlimpia y  sinpublicidad.'),
              onTap: () async => await FlutterWebBrowser.openWebPage(url: authorEmail),
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
              subtitle: ('Icon made by mynamepong from www.flaticon.com'),
              onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/mynamepong'),
            ),
            CommonTitle('Iconos Diseñados por Freepik'),
            SubTitle('Todos los iconos de colores, excepto el hombre corriendo y el icono de la aplicación, fueron diseñados y creados por Freepik'),
            ListCell(
              leading: Image.asset(
                'assets/info.png',
                height: 50.0,
                width: 50.0,
              ),
              title: ('Toca para obtener más información.'),
              subtitle: ('Icons made by Freepik from www.flaticon.com'),
              onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/freepik')
            ),
          ]
        )
      )
    );
  }
}