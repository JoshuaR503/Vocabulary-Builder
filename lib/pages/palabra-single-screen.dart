import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:moblie/model/main.dart';
import 'package:moblie/model/palabra.model.dart';
import 'package:moblie/utils/settings.dart';

import 'package:moblie/widgets/ui/divider.dart';
import 'package:moblie/widgets/ui/head-card.dart';
import 'package:moblie/widgets/ui/text/row-item.dart';
import 'package:moblie/widgets/palabra/single-palabra-card.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';

class SinglePalabraScreen extends StatelessWidget  {

  final Palabra _palabra;

  SinglePalabraScreen(this._palabra);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant <MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
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
                      _buildPalabraBasicInfoCard(context),
                      Separator.spacer(),
                      _buildConjugationCard(context),
                      Separator.spacer(),
                      _buildPalabraForms(context),
                      Separator.spacer(),
                      _buildPalabraDefinitionCard(context),
                      Separator.spacer(),
                      _builPalabraExamplesCard(context),
                      Separator.spacer(),
                      _buildPalabraAntSynCard(context),
                      Separator.spacer(),
                      _buildNoteCard(context),
                    ]
                  ),
                ),
              )
            ],
          )
        );
      },
    );
  }
  Widget _buildPalabraBasicInfoCard(BuildContext context) {
    String notAvailable = FlutterI18n.translate(context, 'single_palabra.not_available.title');
    String palabra = _palabra.palabra;
    String traduccion = _palabra.traduccion;
    String kind = _palabra.tipo;

    return SinglePalabraCard(
      title: FlutterI18n.translate(context, 'single_palabra.extra_details.title'),
      body: Column(
        children: <Widget>[
          RowItem(
            title: FlutterI18n.translate(context, 'single_palabra.extra_details.first_tiem'),
            subtitle: palabra,
            copyClipboard: false,
          ),
          
          Separator.spacer(),
          RowItem(
            title: FlutterI18n.translate(context, 'single_palabra.extra_details.second_item'),
            subtitle: traduccion,
            copyClipboard: false,
          ),

          Separator.spacer(),
          RowItem(
            title: FlutterI18n.translate(context, 'single_palabra.extra_details.third_item'),
            subtitle: kind == null ? notAvailable : kind,
            copyClipboard: false,
          ),
        ],
      ),
    );
  }

  Widget _buildConjugationCard(BuildContext context) {
    Widget card = Container();
    String palabra =_palabra.palabra;

    String presenteC =_palabra.presenteContinuo;
    String thirdP = _palabra.thirdPerson;
    String presente = _palabra.presente;
    String pasado = _palabra.pasado;
    String futuro = _palabra.futuro;
    
    if (presenteC != null && thirdP != null && presente != null &&  pasado != null && futuro != null) {
      
      card = SinglePalabraCard(
        title: FlutterI18n.translate(context, 'single_palabra.verb_card.title', {'palabra': palabra}),
        body: Column(
          children: <Widget>[
            
            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.verb_card.present_continuous'),
              subtitle: presenteC,
              copyClipboard: true
            ),

            Separator.spacer(),
            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.verb_card.third_person'),
              subtitle: pasado,
              copyClipboard: true
            ),

            Separator.spacer(),
            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.verb_card.present'),
              subtitle: presente,
              copyClipboard: true
            ),

            Separator.spacer(),
            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.verb_card.past'),
              subtitle: pasado,
              copyClipboard: true
            ),

            Separator.spacer(),
            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.verb_card.future'),
              subtitle: futuro,
              copyClipboard: true
            ),
          ],
        ),
      );
    }

    return card;
  }

  Widget _buildPalabraForms(BuildContext context) {

    Widget card = Container();

    String singular = _palabra.singular;
    String plural =_palabra.plural;
 
    if (plural != null && singular != null) {
      card = HeadCard(
        title: FlutterI18n.translate(context, 'single_palabra.p_s.first_item', {'palabra': _palabra.palabra}),
        subtitle: plural,
        title2: FlutterI18n.translate( context, 'single_palabra.p_s.second_item', {'palabra': _palabra.palabra}),
        subtitle2: singular
      );
    }

    return card;
  }

  Widget _buildPalabraDefinitionCard(BuildContext context) {

    Widget card = Container();

    String definicion = _palabra.definicion;
    String definicionEs = _palabra.definicionEs;

    if (definicion != null && definicionEs != null) {
      card = HeadCard (
        title: FlutterI18n.translate(context, 'single_palabra.definition.first_item'),
        subtitle: definicion,
        title2: FlutterI18n.translate(context, 'single_palabra.definition.second_item'),
        subtitle2: _palabra.definicionEs
      );
    }
    
    return card;
  }

  Widget _builPalabraExamplesCard(BuildContext context) {

    String ejemplos = _palabra.ejemplos;
    String sinonimos = _palabra.sinonimos;

    String notAvailable = FlutterI18n.translate(context, 'single_palabra.not_available.title');

    return HeadCard(
      title: FlutterI18n.translate(context, 'single_palabra.example.first_item', {'palabra': _palabra.palabra}),
      subtitle: ejemplos == null ? notAvailable : ejemplos,
      title2: FlutterI18n.translate(context, 'single_palabra.example.second_item'),
      subtitle2: sinonimos == null ? notAvailable : sinonimos,
    );
  }

  Widget _buildPalabraAntSynCard(BuildContext context) {

    Widget card = Container();

    String antonyms = FlutterI18n.translate(context, 'single_palabra.antonyms', {'palabra': _palabra.palabra});
    String synonyms = FlutterI18n.translate(context, 'single_palabra.synonyms', {'palabra': _palabra.palabra});
    
    String ns = FlutterI18n.translate(context, 'single_palabra.not_available.ns');
    String na = FlutterI18n.translate(context, 'single_palabra.not_available.na');

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
      card =HeadCard(
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

  Widget _buildNoteCard(BuildContext context) {

    Widget card = Container();

    String nota = _palabra.nota;
    String spanishTranslation = _palabra.traduccion;

    if (nota != null && spanishTranslation != null) {
      card = HeadCard (
        title: FlutterI18n.translate(context, 'single_palabra.note'),
        subtitle: nota,
        title2: FlutterI18n.translate(context, 'single_palabra.spanish_translation'),
        subtitle2: spanishTranslation
      );
    }

    return card;
  }
}