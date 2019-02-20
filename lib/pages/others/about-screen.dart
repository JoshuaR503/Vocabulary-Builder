import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'package:moblie/utils/settings.dart';
import 'package:moblie/widgets/ui/list_cell.dart';
import 'package:moblie/widgets/ui/text/subtitle.dart';
import 'package:moblie/widgets/ui/text/title.dart';

class HelpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
      },
      
      child: Scaffold(
        appBar: AppBar(
          title: Text('Preguntas Frecuentes'),
          centerTitle: true,
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Scrollbar(
            child: ListView(
              children: <Widget>[
                CommonTitle('Preguntas frecuentes'),
                SubTitle('Esta sección está destinada a responder algunas preguntas básicas de los usuarios.'),
                CommonTitle('¿Qué es una oración?'),
                ListCell(
                  title: ('Una breve definición de la oración'),
                  subtitle: ('La oración es la que expresa una idea o pensamiento completo. Ejemplo: el hombre esta corriendo.'),
                  onTap: () {},
                ),  
                CommonTitle('¿Qué es el sujeto?'),
                ListCell(
                  title: ('Una breve definición de sujeto'),
                  subtitle: ('El sujeto es la persona, animal o cosa de la que se habla en una oración. Ejemplo: el hombre, el árbol'),
                  onTap: () {},
                ),

                CommonTitle('¿Qué es un verbo?'),
                SubTitle('En este articulo se dara una breve definición del verbo'),
                ListCell(
                  leading: Image.asset(
                    'assets/running-man.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                  title: ('El verbo:'),
                  subtitle: ('El verbo es la parte de la oración que expresa acción del sujeto. Ejemplo: correr, caminar, leer'),
                  onTap: () {},
                ),

                CommonTitle('¿Que es un sustantivo?'),
                SubTitle('En este articulo se dara una breve definición del sustantivo'),                
                ListCell(
                  leading: Image.asset(
                    'assets/apple.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                  title: ('Un sustantivo: '),
                  subtitle: ('Los sustantivos son palabras con las que se denoniman: personas, animales, cosas, ideas o pensamientos. Ejemplo: manzana, arbol, casa'),
                  onTap: () {},
                ),

                CommonTitle('¿Qué es un adjetivo?'),
                SubTitle('En este articulo se dara una breve definición del adjetivo'),
                ListCell(
                  leading: Image.asset(
                    'assets/plant.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                  title: ('El adjetivo:'),
                  subtitle: ('Un adjetivo es la palabra que modifica al sustantivo, es el que indica alguna característica o cualidad del sustantivo. Ejemplo: verde, alto,   grande'),
                  onTap: () {},
                ),

                CommonTitle('¿Qué es un adverbio?'),
                SubTitle('En este articulo se dara una breve definición del adverbio'),
                ListCell(
                  leading: Image.asset(
                    'assets/planet.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                  title: ('El advervio:'),
                  subtitle: ('Un adverbio es una parte de la oración que complementa a un verbo. Los adverbios expresan circunstancias, como: modo, lugar, tiempo, cantidad, afirmación, etc.'),
                  onTap: () {},
                ),

                CommonTitle('¿No encuentras lo que estás buscando?'),
                ListCell(
                  leading: Image.asset(
                    'assets/info.png',
                    height: 50.0,
                    width: 50.0,
                  ),
                  title: ('Envía tus comentarios'),
                  subtitle: ('Puede enviar una solicitud de nuevas funciones o nuevo contenido, toca aquí para abrir enviar una petición'),
                  onTap: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback),
                ),
              ]
            )
          ),
        )
      )
    );
  }
}