import 'package:flutter/material.dart';
import 'package:vocabulary_builder/model/main.dart';
import 'package:vocabulary_builder/model/palabra.model.dart';
import 'package:vocabulary_builder/pages/palabra-single-screen.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'dart:async';

class PalabraCard extends StatefulWidget {
  final Palabra palabra;
  
  PalabraCard(this.palabra);

  @override
  State<StatefulWidget> createState() => _PalabraCardState();
}

class _PalabraCardState extends  State<PalabraCard> {

  bool _isPlaying = false;
  bool _isButtonDisabled = false;

  void _changeStatus(bool value) {
    setState(() {
       _isPlaying = value;
      _isButtonDisabled = value; 
    });
  }

  Future<Null> reproduceAudio(url) async {
    AudioPlayer audioPlayer = AudioPlayer();

    await audioPlayer
    .play(url)
    .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant <MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () => Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (_) => SinglePalabraScreen(widget.palabra))),

          child: Card(
            child: Column(
              children: <Widget> [
                _buildDataRow(context, model),
                _buildActionButtons(context, model)
              ],
            ),
          )
        );
      }
    );
  }

  Widget _buildDataRow(BuildContext context, MainModel model) {

    TextStyle style = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300);

    Widget content;
    Widget iconButton = IconButton(
      onPressed: () => _save(context, widget.palabra, model),
      icon: Icon(Icons.favorite_border),
      color: Colors.red,
    );

    content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[

            Row(
              children: <Widget>[


                Padding(
                  child: Text(
                    model.userLang == 'en' ? widget.palabra.traduccion : widget.palabra.palabra,
                    style: style
                  ),
                  padding: EdgeInsets.only(left: 13.0),
                ),

                iconButton
              ],
            ),

          ],
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(model.userLang == 'en' ? widget.palabra.palabra : widget.palabra.traduccion),
        )
      ],
    );

    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(7.0),
        child: Container(
          height: 125.0,
          child: content
        )
      )
    );
  }

  Widget _buildActionButtons(BuildContext context, MainModel model) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: _isButtonDisabled ? null : () {

            print('$_isPlaying');
            
            final String es = widget.palabra.traduccionPronunciacion;
            final String en = widget.palabra.palabraPronunciacion;

            print('Audio a reproducir: $es, $en');

            if (!_isPlaying) {
              _changeStatus(true);

              reproduceAudio(
                model.userLang == 'en' 
                  ? es
                  : en
              ).then((_) => Timer(Duration(seconds: 2), () => _changeStatus(false)));
            }
          },

          child: Row(
            children: <Widget>[
              Padding(
                child: Text(

                  FlutterI18n.translate(context, 'home.button_name'),

                  style: TextStyle(
                    fontSize: 14.0, 
                    fontWeight: FontWeight.w400
                  ),
                ),
                padding: EdgeInsets.only(right: 8.0),
              ),
              Icon(Icons.volume_up)
            ],
          ),

        )
      ],
    );
  }

  void _save(BuildContext context, Palabra palabra, MainModel model) async {
    await model
    .save(palabraData: palabra)
    .then((response) {
      if (response != 0) {
         _createSnackBar(
          title: FlutterI18n.translate(context, 'snackbar.success_saving_word'),
          label: FlutterI18n.translate(context, 'snackbar.success_saving_word_label'),
          context: context
        );

        model.sendFeedback(false);
      }
    })
    .catchError((error) {

      print(error);

      _createSnackBar(
        title: FlutterI18n.translate(context, 'snackbar.error_saving_word'),
        label: FlutterI18n.translate(context, 'snackbar.error_saving_word_label'),
        context: context
      );

      model.sendFeedback(true);
    }); 
  }

  void _createSnackBar({String title, String label, BuildContext context}) {
    final snackBar = SnackBar(
      content: Text(title),
      action: SnackBarAction(
        label: label,
        onPressed: () {},
      ),
    );
    
    Scaffold.of(context).showSnackBar(snackBar);
  }
}