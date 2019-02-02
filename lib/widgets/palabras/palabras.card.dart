import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';

import '../../model/palabra.model.dart';
import '../../model/palabra_guardada.model.dart';
import '../../utils/db.helper.dart';
import '../../utils/settings.dart';

class PalabraCard extends StatefulWidget {
  final Palabra palabra;
  
  PalabraCard(this.palabra);

  @override
    State<StatefulWidget> createState() => _PalabraCardState();
}

class _PalabraCardState extends State<PalabraCard> with TickerProviderStateMixin {


  final DatabaseHelper helper = DatabaseHelper();
  final FlutterTts flutterTts = new FlutterTts();
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
  }

  Widget _buildDataRow(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,

        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(7.0),

          child: Container(
            height: 120.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => _save(
                        dataPalabra: widget.palabra.palabra, 
                        dataTraduccion: widget.palabra.traduccion,
                        context: context
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            child: Text(
                              widget.palabra.palabra,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                            padding: EdgeInsets.only(right: 2.0),
                          ),
                          Icon(Icons.bookmark_border),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.0),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(widget.palabra.traduccion),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () => _speak(widget.palabra.palabra),     
          child: Row(
            children: <Widget>[
              Padding(
                child: Text(
                  buttonName,
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

  void _save({String dataPalabra, String dataTraduccion, BuildContext context}) async {
    int result;

    PalabraGuardada singlePalabra = PalabraGuardada(
      palabra: dataPalabra,
      traduccion: dataTraduccion,
      date: DateFormat.yMMMd().format(DateTime.now())
    );

    result = await helper.savePalabra(singlePalabra);

    if (result != 0) {
      _buildSnackBar(context, success: true);
    } else {
      _buildSnackBar(context, success: false);
    } 
  }

  void _buildSnackBar(BuildContext context, {bool success}) {
    
    Widget snackbar = Container();

    if(success) {
      snackbar = SnackBar(content: Text(onSuccessMessage));
    } else {
      snackbar = SnackBar(content: Text(onErrorMessage));
    }

    Scaffold.of(context).showSnackBar(snackbar);
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          _buildDataRow(context),
          _buildActionButtons(context)
        ],
      ),
    );
  }
  
}