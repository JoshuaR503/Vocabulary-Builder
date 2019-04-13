import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vocabulary_builder/model/main.dart';
import 'package:vocabulary_builder/model/palabra.model.dart';
import 'package:vocabulary_builder/utils/settings.dart';

import 'package:vocabulary_builder/widgets/ui/divider.dart';
import 'package:vocabulary_builder/widgets/ui/head-card.dart';
import 'package:vocabulary_builder/widgets/ui/text/row-item.dart';
import 'package:vocabulary_builder/widgets/palabra/single-palabra-card.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vocabulary_builder/widgets/ui/text/title.dart';

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
                  // child: Column(
                  //   children: <Widget>[              
                  //     _buildPalabraBasicInfoCard(context),
                  //     Separator.spacer(),
                  //     _buildConjugationCard(context),
                  //     Separator.spacer(),
                  //     _buildPalabraDefinitionCard(context),
                  //     Separator.spacer(),
                  //     _builPalabraExamplesCard(context),
                  //     Separator.spacer(),
                  //     _buildPalabraAntSynCard(context),
                  //     Separator.spacer(),
                  //     _buildNoteCard(context),
                  //   ]

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      _buildPalabraBasicInfoCard(context),
                      Separator.spacer(),
                      _buildInidicativeConjugationCard(context),
                      Separator.spacer(),
                      _buildConjugationCard(context),
                      Separator.spacer(),
                      _buildPalabraDefinitionCard(context),
                      Separator.spacer(),
                      _builPalabraExamplesCard(context),
                      Separator.spacer(),
                      _buildPalabraAntSynCard(context),
                      Separator.spacer(),
                      _buildNoteCard(context),
                      Separator.spacer(),
                    ],
                  ),
                  // ),
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
    String kind = _palabra.categoriaGramatical;

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

    final String presente =  _palabra.presente;
    final String presenteC = _palabra.presenteContinuo;
    final String pasado = _palabra.pasado;
    final String futuro = _palabra.futuro;

    print('PRESENTE $presente, PRESENTE CONTINUO $presenteC, PASADO $pasado, FUTURO $futuro');
    
    if (
      presente.length > 3 && presente != null &&
      presenteC.length > 3 && presenteC != null &&
      pasado.length > 3 && pasado != null &&
      futuro.length > 3 && futuro != null
      ) {
      
      card = SinglePalabraCard(
        title: FlutterI18n.translate(context, 'single_palabra.verb_card.title'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.verb_card.present'),
              subtitle: presente,
              copyClipboard: true
            ),
            Separator.spacer(),

            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.verb_card.present_continuous'),
              subtitle: presenteC,
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

  Widget _buildInidicativeConjugationCard(BuildContext context) {
    Widget card = Container();

    final String primeraPersona = _palabra.primeraPersona;
    final String segundaPersona = _palabra.segundaPersona;
    final String terceraPersona = _palabra.terceraPersona;

    if (
      primeraPersona.length > 3 && primeraPersona != null &&
      segundaPersona.length > 3 && segundaPersona != null &&
      terceraPersona.length > 3 && terceraPersona != null
      ) {
      
      card = SinglePalabraCard(
        title: FlutterI18n.translate(context, 'single_palabra.conjugation_indicative.title'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            
            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.conjugation_indicative.primera_persona'),
              subtitle: primeraPersona,
              copyClipboard: true
            ),
            Separator.spacer(),

            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.conjugation_indicative.segunda_persona'),
              subtitle: segundaPersona,
              copyClipboard: true
            ),
            Separator.spacer(),
            
            RowItem(
              title: FlutterI18n.translate(context, 'single_palabra.conjugation_indicative.segunda_persona'),
              subtitle: terceraPersona,
              copyClipboard: true
            ),
            Separator.spacer(),
          ],
        ),
      );
    }

    return card;
  }

  Widget _buildPalabraDefinitionCard(BuildContext context) {

    Widget card = Container();

    String definicion = _palabra.definicion;
    String definicion2 = _palabra.definicion2;

    print('$definicion, $definicion2');

    if (definicion != null && definicion2 != null) {
      card = HeadCard (
        title: FlutterI18n.translate(context, 'single_palabra.definition.first_item'),
        subtitle: definicion,
        title2: FlutterI18n.translate(context, 'single_palabra.definition.second_item'),
        subtitle2: definicion2
      );
    }
    
    return card;
  }

  Widget _builPalabraExamplesCard(BuildContext context) {

    String ejemplo = _palabra.ejemplo;
    String sinonimos = _palabra.sinonimos;

    String notAvailable = FlutterI18n.translate(context, 'single_palabra.not_available.title');

    return HeadCard(
      title: FlutterI18n.translate(context, 'single_palabra.example.first_item', {'palabra': _palabra.palabra}),
      subtitle: ejemplo == null ? notAvailable : ejemplo,
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