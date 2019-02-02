import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';

import '../../model/palabra.model.dart';
import '../../model/palabra_guardada.model.dart';
import '../../utils/db.helper.dart';

class PalabraCard extends StatelessWidget {

  final FlutterTts flutterTts = new FlutterTts();
  final Palabra palabra;
  
  PalabraCard(this.palabra);

  final DatabaseHelper helper = DatabaseHelper();

  Widget _buildDataRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,

      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(7.0),

        child: Container(
          height: 110.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => _save(
                      dataPalabra: palabra.palabra, 
                      dataTraduccion: palabra.traduccion,
                      context: context
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          child: Text(
                            palabra.palabra,
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
                child: Text(palabra.traduccion),
              )
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

  void _save({String dataPalabra, String dataTraduccion, BuildContext context}) async {
    int result;

    PalabraGuardada singlePalabra = PalabraGuardada(
      palabra: dataPalabra,
      traduccion: dataTraduccion,
      date: DateFormat.yMMMd().format(DateTime.now())
    );
    
    print(singlePalabra);

    result = await helper.savePalabra(singlePalabra);

    if (result != 0) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Palabra guardada correctamente')));
		} else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Hubo un problema al guardar los datos!')));
		}
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