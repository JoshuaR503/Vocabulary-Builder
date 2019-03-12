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
                    _buildPalabraSinPlu(),
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
          RowItem(
            'Palabra', 
            _palabra.palabra,
            false
          ),
          
          Separator.spacer(),
          RowItem(
            'Traducción',
            _palabra.traduccion,
            false
          ),

          Separator.spacer(),
          RowItem(
            'Categoría gramatical', 
            _palabra.tipo == null ? 'No disponible' : _palabra.tipo,
            false
          ),
        ],
      ),
    );
  }

  Widget _buildConjugationCard() {

    Widget card = Container();
    
    String tipo = _palabra.tipo;

    if (tipo == 'Verbo') {
      card = SinglePalabraCard(
        title: 'Conjugación de ${_palabra.palabra}',
        body: Column(
          children: <Widget>[
            RowItem(
              'Presente Continuo',
              _palabra.presenteContinuo ?? _palabra.presenteContinuo,
              true
            ),
            Separator.spacer(),
            RowItem(
              'Tercera Persona',
              _palabra.thirdPerson ?? _palabra.thirdPerson,
              true
            ),
            Separator.spacer(),
            RowItem(
              'Presente',
              _palabra.presente ?? _palabra.presente,
              true
            ),
            Separator.spacer(),
            RowItem(
              'Pasado', 
              _palabra.pasado ?? _palabra.pasado,
              true
            ),
            Separator.spacer(),
            RowItem(
              'Futuro', 
              _palabra.futuro ?? _palabra.futuro,
              true
            ),
          ],
        ),
      );
    } 

    return card;
  }

  Widget _buildPalabraSinPlu() {

    Widget card = Container();

    String singular = _palabra.singular;
    String plural =_palabra.plural;
 
    if (plural != null && singular != null) {
      card = HeadCard(
        title: '${_palabra.palabra} en Plural',
        subtitle: plural,
        title2: '${_palabra.palabra} en Singular',
        subtitle2: singular
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

    String antonyms = 'Antónimos de ${_palabra.palabra}:';
    String synonyms = 'Sinónimos de ${_palabra.palabra}:';
    String ns = 'Parece que no hay sinónimos disponibles para esta palabra.';
    String na = 'Parece que no hay antónimos disponibles para esta palabra.';

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