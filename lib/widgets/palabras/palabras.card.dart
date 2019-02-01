import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../model/palabra.model.dart';

class PalabraCard extends StatelessWidget {

  final FlutterTts flutterTts = new FlutterTts();
  final Palabra palabra;
  
  PalabraCard(this.palabra);

  Widget _renderContainer({bool traduccion = false}) {

    Widget content = Container();

    if (traduccion) {
      content = Container(
        child: Text(palabra.traduccion),
      );
    } else {
      content = Container(
        child: Text(
          palabra.palabra,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w300
          ),
        ),
      );
    }

    return content;
  }

  Widget _buildPalabraRow() {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,

      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(7.0),

        child: Container(
          height: 110.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 6.0),
              _renderContainer(),
              SizedBox(height: 20.0),
              _renderContainer(traduccion: true),
              SizedBox(height: 6.0),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () => _speak(palabra.palabra),     
          child: Row(
            children: <Widget>[
              Padding(
                child: Text(
                  'Escuchar Pronunciación',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300
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

  void _speak(String text) { 
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.8);
    flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildPalabraRow(),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}