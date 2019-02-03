import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../widgets/palabra/single-palabra-card.dart';
import '../widgets/ui/head-card.dart';
import '../widgets/ui/row-item.dart';
import '../widgets/ui/divider.dart';
import '../model/palabra-info.model.dart';
import '../model/palabra.model.dart';
import '../utils/settings.dart';
import '../model/main.dart';

class SinglePalabraScreen extends StatelessWidget {
  final Palabra _palabra;

  SinglePalabraScreen(this._palabra);

  final PalabraInfo palabra = PalabraInfo(
    palabra: 'Hola',
    traduccion: 'Hello',
    synonyms: ['Hi', 'Hi there'],
    meaning: 'used as a friendly greeting or to attract attention.',
    examples: ['Hi there.', 'How was the fligh? Hi, how are you doing?'],
    type: 'Verbo',
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
      title1: 'Significado:',
      subtitle1: palabra.meaning,
      title2: 'Ejemplos:',
      subtitle2: palabra.examples.toString(),
      title3: 'Sinonimos:',
      subtitle3: palabra.synonyms
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