import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'package:moblie/utils/settings.dart';
import 'package:moblie/widgets/ui/list_cell.dart';
import 'package:moblie/widgets/ui/text/subtitle.dart';
import 'package:moblie/widgets/ui/text/title.dart';

class QuestionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas Frecuentes'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            CommonTitle('¿Cómo obtengo más palabras?'),
            ListCell(
              title: 'Una simple solución',
              subtitle: ('Para obtener más palabras, simplemente toca el botón de recarga en la parte superior derecha o simplemente desliza tu dedo hacia abajo.'),
              onTap: () {},
            ),
            CommonTitle('¿Qué es una oración?'),
            ListCell(
              title: ('Breve definición de la oración'),
              subtitle: ('La oración es aquello que expresa una idea o pensamiento. Ejemplos: el hombre esta corriendo, estoy aprendiendo inglés.'),
              onTap: () {},
            ),
            CommonTitle('¿Qué significa singular?'),
            ListCell(
              leading: Image.asset(
                'assets/mushroom.png',
                height: 50.0,
                width: 50.0,
              ),
              title: ('Una breve definición de singular'),
              subtitle: ('Singular se refiere a cuando hablamos de solamente una cosa en particular. Ejemplos: un hongo, el carro, una casa'),
              onTap: () {},
            ),
            CommonTitle('¿Qué significa plural?'),
            ListCell(
              leading: Image.asset(
                'assets/tree.png',
                height: 50.0,
                width: 50.0,
              ),
              title: ('Una breve definición de plural'),
              subtitle: ('Plural, se refiere a cuando hablamos de más de una sola cosa. Ejemplos: unos hongos, los arboles, las casas'),
              onTap: () {},
            ),
            CommonTitle('¿Qué son los "sinónimos"?'),
            ListCell(
              title: ('Una breve definición de los sinónimos'),
              subtitle: ('Los sinónimos son palabras que tienen el mismo significado de otras palabras. Ejemplos: comprender - entender, fácil - sencillo, estudiante -	alumno'),
              onTap: () {},
            ),
            CommonTitle('¿Qué son los "antónimos"?'),
            ListCell(
              title: ('Una breve definición de los antónimos'),
              subtitle: ('Los antónimos son aquellas palabras cuyos significados son opuestos. Ejemplos: luz - oscuridad, alto - bajo, pequeño - grande'),
              onTap: () {},
            ),
            CommonTitle('¿Qué es el sujeto?'),
            SubTitle('Una breve definición del sujeto'),
            ListCell(
              leading: Image.asset(
                'assets/parrot.png',
                height: 50.0,
                width: 50.0,
              ),
              title: ('Una breve definición de sujeto'),
              subtitle: ('El sujeto es la persona, animal o cosa de la que se habla en una oración. Ejemplo: el pájaro, el árbol, la casa.'),
              onTap: () {},
            ),
            CommonTitle('¿Qué es un verbo?'),
            SubTitle('Una breve definición del verbo'),
            ListCell(
              leading: Image.asset(
                'assets/running-man.png',
                height: 50.0,
                width: 50.0,
              ),
              title: ('El verbo:'),
              subtitle: ('El verbo es la parte de la oración que expresa acción del sujeto. Ejemplo: el hombre esta corriendo, el pájaro esta cantando.'),
              onTap: () {},
            ),
            CommonTitle('¿Qué es un sustantivo?'),
            SubTitle('Una breve definición del sustantivo'),                
            ListCell(
              leading: Image.asset(
                'assets/apple.png',
                height: 50.0,
                width: 50.0,
              ),
              title: ('Un sustantivo:'),
              subtitle: ('Los sustantivos son palabras con las que se denoniman personas, animales, cosas, ideas o pensamientos. Ejemplo: manzana, árbol, casa.'),
              onTap: () {},
            ),
            CommonTitle('¿Qué es un adjetivo?'),
            SubTitle('Una breve definición del adjetivo'),
            ListCell(
              leading: Image.asset(
                'assets/plant.png',
                height: 50.0,
                width: 50.0,
              ),
              title: ('El adjetivo:'),
              subtitle: ('Un adjetivo es la palabra que modifica al sustantivo, es el que indica alguna característica o cualidad del sustantivo. Ejemplo: verde, alto, grande.'),
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
              subtitle: ('Un adverbio es una parte de la oración que complementa a un verbo. Los adverbios expresan circunstancias, como modo, lugar, tiempo, cantidad, etc.'),
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
    );
  }
}