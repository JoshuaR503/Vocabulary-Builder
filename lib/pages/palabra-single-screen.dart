import 'package:flutter/material.dart';

import 'package:moblie/model/main.dart';
import 'package:moblie/model/palabra.model.dart';
import 'package:moblie/utils/settings.dart';

import 'package:moblie/widgets/ui/divider.dart';
import 'package:moblie/widgets/ui/head-card.dart';
import 'package:moblie/widgets/ui/text/row-item.dart';
import 'package:moblie/widgets/palabra/single-palabra-card.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class SinglePalabraScreen extends StatelessWidget {
  final Palabra _palabra;
  final MainModel model;

  SinglePalabraScreen(this._palabra, this.model);

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
              icon: Icon(Icons.info_outline),
              onPressed: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback)
            ),
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () => Navigator.pushNamed(context, '/question'),
            )
          ],
        ),

        body: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[              
                    _buildPalabraBasicInfoCard(),
                    Separator.spacer(),
                    _buildConjugationCard(),
                    _buildPalabraDefinitionCard(),
                    Separator.spacer(),
                    _builPalabraExamplesCard(),
                    Separator.spacer(),
                    _buildPalabraAntSynCard(), 
                    Separator.spacer(),
                    _buildNoteCard(),
                  ]
                ),
              ),
            )
          ],
        )
      ),
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
            'Traducción',
            _palabra.traduccion
          ),

          Separator.spacer(),
          RowItem.textRow(
            'Categoría gramatical', 
            _palabra.tipo == null ? 'No disponible' : _palabra.tipo
          ),
        ],
      ),
    );
  }

  Widget _buildConjugationCard() {

    Widget card = Container();

    String tipo = _palabra.tipo;
    String singular = _palabra.singular;
    String plural =_palabra.plural;
    print(tipo);

    if (tipo == 'Verbo') {
      card = SinglePalabraCard(
        title: 'Conjugación de ${_palabra.palabra}',
        body: Column(
          children: <Widget>[
            RowItem.textRow(
              'Presente Continuo',
              _palabra.presenteContinuo ?? _palabra.presenteContinuo,
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Tercera Persona',
              _palabra.thirdPerson ?? _palabra.thirdPerson,
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Presente',
              _palabra.presente ?? _palabra.presente,
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Pasado', 
              _palabra.pasado ?? _palabra.pasado,
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Futuro', 
              _palabra.futuro ?? _palabra.futuro,
            ),
          ],
        ),
      );
    } else if (tipo == 'Sustantivo' && plural != null && singular != null) {
      card = SinglePalabraCard(
        title: 'Singular y plural de ${_palabra.palabra}',
        body: Column(
          children: <Widget>[
            RowItem.textRow(
              'Singular',
              singular
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Plurar',
              plural
            ),
          ],
        ),
      );
    } else if (tipo == 'Sustantivo' && plural != null && singular == null) {
      card = SinglePalabraCard(
        title: 'Singular y plural de ${_palabra.palabra}',
        body: Column(
          children: <Widget>[
            RowItem.textRow(
              'Singular',
              'No disponible'
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Plurar',
              plural
            ),
          ],
        ),
      );
    } else if (tipo == 'Sustantivo' && plural == null && singular != null) {
      card = SinglePalabraCard(
        title: 'Singular y plural de ${_palabra.palabra}',
        body: Column(
          children: <Widget>[
            RowItem.textRow(
              'Singular',
              singular
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Plurar',
              'No disponible'
            ),
          ],
        ),
      );
    }

    return card;
  }

  Widget _buildPalabraDefinitionCard() {

    Widget card = Container();

    if (_palabra.definicion != null && _palabra.definicionEs != null) {
      card = Column(
        children: <Widget>[
          Separator.spacer(),
          HeadCard (
            title: 'Breve definición:',
            subtitle: _palabra.definicion,
            title2: 'Breve definición en Español:',
            subtitle2: _palabra.definicionEs
          )
        ],
      );
    }
    
    return card;
  }

  Widget _builPalabraExamplesCard() {
    return HeadCard(
      title: '${_palabra.palabra} en una oración:',
      subtitle: _palabra.ejemplos == null ? 'No disponible' : _palabra.ejemplos,
      title2: '¿Hay mas traducciones?',
      subtitle2: _palabra.alt == true ? 'Si' : 'No',
    );
  }

  Widget _buildPalabraAntSynCard() {

    Widget card = Container();

    String antonyms = 'Antónimos:';
    String synonyms = 'Sinónimos:';
    String ns = 'Parece que no hay sinónimos para esta palabra.';
    String na = 'Parece que no hay antónimos para esta palabra.';

    String antonimos = _palabra.antonimos;
    String sinonimos = _palabra.sinonimos;

    if (antonimos != null && sinonimos != null) {
      card = HeadCard(
        title: antonyms,
        subtitle: antonimos,
        title2: synonyms,
        subtitle2: sinonimos
      );
    } else if (antonimos == null && sinonimos != null) {
      card = HeadCard(
        title: antonyms,
        subtitle: na,
        title2: synonyms,
        subtitle2: sinonimos
      );
    } else if (antonimos != null && sinonimos == null) {
      card = HeadCard(
        title: antonyms,
        subtitle: antonimos,
        title2: synonyms,
        subtitle2: ns
      );
    }
    
    return card;
  }

  Widget _buildNoteCard() {
    Widget card = Container();

    if (_palabra.nota != null) {
      card = Column(
        children: <Widget>[
          Separator.spacer(),
          HeadCard (
            title: 'Nota',
            subtitle: _palabra.nota,
            title2: 'Traducción Español:',
            subtitle2: _palabra.traduccion
          )
        ],
      );
    }

    return card;
  }
}