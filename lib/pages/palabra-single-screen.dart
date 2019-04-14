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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildPalabraBasicInfoCard(context),
                      _buildInidicativeConjugationCard(context),
                      _buildConjugationCard(context),
                      _buildPalabraDefinitionCard(context),
                      _builPalabraExamplesCard(context),
                      _buildPalabraAntSynCard(context),
                      _buildNoteCard(context),
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

    return Column(
      children: <Widget>[
        SinglePalabraCard(
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
                title: FlutterI18n.translate(context, 'single_palabra.extra_details.fourth_item'),
                subtitle: kind == null ? notAvailable : kind,
                copyClipboard: false,
              ),
            ],
          ),
        ),

        Separator.spacer(),
      ],
    );
  }

  Widget _buildInidicativeConjugationCard(BuildContext context) {
    Widget card = Container();

    final String primeraPersona = _palabra.primeraPersona;
    final String segundaPersona = _palabra.segundaPersona;
    final String terceraPersona = _palabra.terceraPersona;

    if (
      primeraPersona != null &&
      segundaPersona != null &&
      terceraPersona != null
      ) {
      
      card = Column(
        children: <Widget>[
          SinglePalabraCard (
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
                  title: FlutterI18n.translate(context, 'single_palabra.conjugation_indicative.tercera_persona'),
                  subtitle: terceraPersona,
                  copyClipboard: true
                ),
                Separator.spacer(),
              ],
            ),
          ),

          Separator.spacer(),
        ]
      );
    }

    return card;
  }

  Widget _buildConjugationCard(BuildContext context) {
    Widget card = Container();

    final String presente =  _palabra.presente;
    final String presenteC = _palabra.presenteContinuo;
    final String pasado = _palabra.pasado;
    final String futuro = _palabra.futuro;
    
    if (presente != null && presenteC != null && pasado != null && futuro != null ) {
      
      card = Column(
        children: <Widget>[
          SinglePalabraCard(
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
          ),

          Separator.spacer(),
        ],
      );
    }

    return card;
  }

  Widget _buildPalabraDefinitionCard(BuildContext context) {

    Widget card = Container();

    String definicion = _palabra.definicion;
    String definicion2 = _palabra.definicion2;

    if (definicion != null && definicion2 != null) {
      card = Column(
        children: <Widget>[
          HeadCard (
            title: FlutterI18n.translate(context, 'single_palabra.definition.first_item'),
            subtitle: definicion,
            title2: FlutterI18n.translate(context, 'single_palabra.definition.second_item'),
            subtitle2: definicion2
          ),

          Separator.spacer(),
        ],
      );
    }
    
    return card;
  }

  Widget _builPalabraExamplesCard(BuildContext context) {

    String ejemplo = _palabra.ejemplo;
    String ejemplo2 = _palabra.ejemplo2;

    String notAvailable = FlutterI18n.translate(context, 'single_palabra.not_available.title');

    return Column(
      children: <Widget>[
        HeadCard(
          title: FlutterI18n.translate(context, 'single_palabra.example.first_item', {'palabra': _palabra.palabra}),
          subtitle: ejemplo == null ? notAvailable : ejemplo,
          title2: FlutterI18n.translate(context, 'single_palabra.example.second_item', {'palabra': _palabra.palabra}),
          subtitle2: ejemplo2 == null ? notAvailable : ejemplo2,
        ),

        Separator.spacer(),
      ],
    );
  }

  Widget _buildPalabraAntSynCard(BuildContext context) {

    final String notAvailable = FlutterI18n.translate(context, 'single_palabra.not_available.title');

    final String antonyms = FlutterI18n.translate(context, 'single_palabra.antonyms', {'palabra': _palabra.palabra});
    final String synonyms = FlutterI18n.translate(context, 'single_palabra.synonyms', {'palabra': _palabra.palabra});
 
    final String ns = FlutterI18n.translate(context, 'single_palabra.not_available.ns');
    final String na = FlutterI18n.translate(context, 'single_palabra.not_available.na');

    final String antonimos = _palabra.antonimos;
    final String sinonimos = _palabra.sinonimos;

    Widget card;

    if (antonimos == null && sinonimos == null) {
      card = Container();
    } else {
      card = Column(
      children: <Widget>[
          HeadCard(
            title: antonyms,
            subtitle: antonimos == null ? na : antonimos.length > 1 ? antonimos : notAvailable,
            title2: synonyms,
            subtitle2: sinonimos == null ? ns : sinonimos.length > 1 ? sinonimos : notAvailable,
          ),

          Separator.spacer(),
        ],
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
      );
    }

    return card;
  }
}