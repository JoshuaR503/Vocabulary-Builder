import 'package:flutter/material.dart';

import 'package:moblie/widgets/ui/text/subtitle.dart';
import 'package:moblie/widgets/ui/text/title.dart';

import '../../widgets/ui/list_cell.dart';
import '../../widgets/ui/divider.dart';

class AboutScreen extends StatelessWidget {

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
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Scrollbar(

            child: ListView(children: <Widget>[
              CommonTitle('¿Qué es un verbo?'),
              SubTitle('En este articulo se discutira que es un verbo.'),
              ListCell(
                leading: Image.asset(
                  'assets/running-man.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('El verbo de acuerdo a Wikipedia'),
                subtitle: ('El verbo es la parte de la oración que expresa acción, sujeto y estado del sujeto. Ejemplo: correr, caminar, leer'),
                onTap: () {},
              ),
              
              CommonTitle('¿Que es un sustantivo?'),
              SubTitle('En este articulo se discutira que es un sustantivo'),
              ListCell(
                leading: Image.asset(
                  'assets/apple.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('Un sustantivo de acuerdo a Wikipedia'),
                subtitle: ('Los sustantivos son palabras con las que se designan y clasifican los seres y las entidades de la realidad. Ejemplo: manzana, arbol, casa'),
                onTap: () {},
              ),

              CommonTitle('¿Qué es un adjetivo?'),
              SubTitle('En este articulo se discutira que es un adjetivo'),
              ListCell(
                leading: Image.asset(
                  'assets/plant.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: ('El sustantivo:'),
                subtitle: ('Un adjetivo es la palabra que modifica al sustantivo, es el que indica alguna característica o cualidad del sustantivo. Ejemplo: verde, grande, alto'),
                onTap: () {},
              ),
              ])
            ),
        )
      )
    );
  }
}