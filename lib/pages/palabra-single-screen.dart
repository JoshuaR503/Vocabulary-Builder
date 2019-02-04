import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../widgets/palabra/single-palabra-card.dart';
import '../widgets/ui/head-card.dart';
import '../widgets/ui/row-item.dart';
import '../widgets/ui/divider.dart';
import '../model/palabra-info.model.dart';
import '../model/palabra.model.dart';
import '../utils/settings.dart';

class SinglePalabraScreen extends StatelessWidget {
  final Palabra _palabra;

  SinglePalabraScreen(this._palabra);

  final PalabraInfo palabra = PalabraInfo(
    palabra: 'Hola',
    traduccion: 'Hello',
    synonyms: 'Hi, Hi there',
    meaning: 'used as a friendly greeting or to attract attention.',
    examples: 'How was the fligh? Hi, how are you doing?',
    type: 'Sustantivo',
    alt: true,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
      },

      child: Scaffold(
        appBar: AppBar( 
          title: Text(_palabra.palabra),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => FlutterWebBrowser
                .openWebPage(url: '$outSideDictionary/${_palabra.palabra}')
            ),
          ],
        ),
        body: Builder(
          builder: (context) => ListView(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: <Widget>[
                    _buildPalabraBasicInfoCard(),
                    Separator.spacer(),
                    _buildPalabraExtraInfoCard(),
                  ]),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget _buildPalabraExtraInfoCard() {
    return HeadCard(
      type: 'Tipo de Palabra:',
      subType: palabra.type,
      synonyms: 'Sinonimos:',
      subSynonyms: palabra.synonyms,
      definicion: 'Definición:',
      subDefinicion: palabra.meaning,
      examples: 'Ejemplos:',
      subExamples: palabra.examples,
    );
  }

  Widget _buildPalabraBasicInfoCard() {
    return SinglePalabraCard(
      title: 'Detalles adicionales',
      body: Column(
        children: <Widget>[
          RowItem.textRow(
            'Palabra', 
            _palabra.palabra
          ),
          Separator.spacer(),
          RowItem.textRow(
            'Traduccion',
            _palabra.traduccion
          ),
          Separator.spacer(),
          RowItem.textRow(
            '¿Hay otra traducción?',
            palabra.alt == true ? 'Si' : 'No' 
          ),
        ],
      ),
    );
  }

}