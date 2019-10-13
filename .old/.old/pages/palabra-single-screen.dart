import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vocabulary_builder/model/main.dart';
import 'package:vocabulary_builder/model/palabra.model.dart';
import 'package:vocabulary_builder/utils/colors.dart';
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
            title: Text( 
              model.userLang == 'en' 
                ? _palabra.traduccion
                : _palabra.palabra
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback)
              ),
              IconButton(
                icon: Icon(Icons.help_outline),
                onPressed: () => Navigator.pushNamed(context, '/help'),
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
                      _builPalabraExamplesCard(context),
                      _buildPalabraDefinitionCard(context, model),
                      _buildPalabraSynonymsCard(context, model),
                      Separator.spacer(),
                      _buildPalabraAntonymsCard(context, model),
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
                title: FlutterI18n.translate(context, 'single_palabra.extra_details.third_item'),
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

  Widget _buildPalabraDefinitionCard(BuildContext context, MainModel model) {

    Widget card = Container();

    final String definicion = _palabra.definicion;
    final String definicion2 = _palabra.definicion2;
    final String notAvailable = FlutterI18n.translate(context, 'single_palabra.not_available.title');
    final String spanish = FlutterI18n.translate(context, 'single_palabra.definition.first_item');
    final String english = FlutterI18n.translate(context, 'single_palabra.definition.second_item');

    if (definicion != null && definicion2 != null) {
      card = Column(
        children: <Widget>[
          HeadCard (
            title: model.userLang == 'en' ? spanish : english,
            subtitle: definicion.length > 1 ? definicion : notAvailable,
            title2: model.userLang == 'en' ? english : spanish,
            subtitle2: definicion2.length > 1 ? definicion2 : notAvailable,
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

  Widget _buildPalabraSynonymsCard(BuildContext context, MainModel model) {

    final String synonyms = FlutterI18n.translate(context, 'single_palabra.synonyms');
    final String ns = FlutterI18n.translate(context, 'single_palabra.not_available.ns');
    final String sinonimos = _palabra.sinonimos;

    Widget card;

    if (sinonimos != null) {

      final List sinonimosArr = _palabra.sinonimos.split(',');

      card = Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: <Widget>[

            Separator.spacer(height: 20),
            _title(synonyms),
            Separator.spacer(),
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              height: 50.0,
              child: sinonimosArr.length >= 1
              
              ?  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sinonimosArr.length,
                itemBuilder: (context, index) =>
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: _renderButton(sinonimosArr[index], model, context),
                  )
              ) : _subtitle(ns)
            ),

            Separator.spacer(height: 15),
          ],
        )
      );
    } else {
      card = Container();
    }

    return card;
  } 

  Widget _buildPalabraAntonymsCard(BuildContext context, MainModel model) {

    final String antonyms = FlutterI18n.translate(context, 'single_palabra.antonyms');
    final String na = FlutterI18n.translate(context, 'single_palabra.not_available.na');
    final String antonimos = _palabra.antonimos;

    Widget card;

    if (antonimos != null) {

      final List anotnimosArr = _palabra.antonimos.split(',');

      card = Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: <Widget>[

            Separator.spacer(height: 20),

            _title(antonyms),
            Separator.spacer(),
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              height: 50.0,
              child: anotnimosArr.length >= 1 

              ? ListView.builder(  
                scrollDirection: Axis.horizontal,
                itemCount: anotnimosArr.length,
                itemBuilder: (context, index) =>
                  Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: _renderButton(anotnimosArr[index], model, context),
                  )
              ) : _subtitle(na)
            ),

            Separator.spacer(height: 15),
          ],
        )
      );
    } else {
      card = Container();
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

  Widget _title(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(text, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0,
                  )
                ),
              ],
            ),
          ),
        ]),
      ])
    );
  }

  Widget _subtitle(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 1, right: 1),
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(text, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: secondaryText
                  )
                ),
              ],
            ),
          ),
        ]),
      ])
    );
  }
  
  Widget _renderButton(String text, MainModel model, BuildContext context) {
    

    final int length = text.length;
    final String lang = model.userLang == 'en' ? 'es' : 'en';
    final String word = model.userLang == 'en' ? _palabra.traduccion : _palabra.palabra;

    final String curatedWord = word.trim().replaceAll(RegExp(r"\s+\b|\b\s"), "-");
    final String curatedString = text.trim().replaceAll(RegExp(r"\s+\b|\b\s"), "-");

    final String url = 'https://s3.amazonaws.com/vocabulary-polly-sound-files/$lang-$curatedWord-$curatedString.mp3';

    print(url);

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color:  Colors.black.withOpacity(0.8),
      ),

      height: 40.0,
      width: length < 8 ? length * 15.0 : length * 11.0,

      child: InkWell(
        onTap: () {
          model.checkInternetConnection();
          model.internetConnected 
            ? model.playAduio(url: url)
            : _showAlert(context);
        },
  
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }




  void _showAlert(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(FlutterI18n.translate(context, 'error_message.no_connection.message')),
          content: SingleChildScrollView(
            child: Text(FlutterI18n.translate(context, 'error_message.no_connection.solution'))
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(FlutterI18n.translate(context, 'error_message.no_connection.btn')),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );  
  }
}