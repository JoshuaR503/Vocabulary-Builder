import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/model/main.dart';
import 'package:vocabulary_builder/model/palabra.model.dart';
import 'package:vocabulary_builder/utils/colors.dart';
import 'package:vocabulary_builder/widgets/ui/elements/slim-card.dart';
import 'package:scoped_model/scoped_model.dart';

class PalabraGuardadaCard extends StatelessWidget {
  final Palabra palabra;

  PalabraGuardadaCard(this.palabra);

  Widget build(BuildContext context) {

    final Palabra singlePalabra =  Palabra(
      palabra: palabra.palabra,
      palabraPronunciacion: palabra.palabraPronunciacion,

      traduccion: palabra.traduccion,
      traduccionPronunciacion: palabra.traduccionPronunciacion,

      dificultad: palabra.dificultad,

      primeraPersona: palabra.primeraPersona,
      segundaPersona: palabra.segundaPersona,
      terceraPersona: palabra.terceraPersona,
      pasado: palabra.pasado,
      presente: palabra.presente,
      futuro: palabra.futuro,

      sinonimos: palabra.sinonimos,
      antonimos: palabra.antonimos,
      definicion: palabra.definicion,
      definicion2: palabra.definicion2,
      ejemplo: palabra.ejemplo,
      categoriaGramatical: palabra.categoriaGramatical,
      nota: palabra.nota,
    );

    return ScopedModelDescendant<MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return SlimCard(
          title: model.userLang == 'en' 
            ? singlePalabra.traduccion
            : singlePalabra.palabra,
          
          subtitle: model.userLang == 'en' 
            ? singlePalabra.palabra
            : singlePalabra.traduccion,

          firstAvatar: CircleAvatar(
		      	backgroundColor: yellowAmbarColor,
		      	child: Icon(Icons.volume_up, color: Colors.white),
		      ),

          secondtAvatar: CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.arrow_forward, color: Colors.white),
          ),

          firstFunction: () async {

            final String english = singlePalabra.palabraPronunciacion;
            final String spanish = singlePalabra.traduccionPronunciacion;

            AudioPlayer audioPlayer = AudioPlayer();

            await audioPlayer
            .play(model.userLang == 'es' 
            ? english 
            : spanish, isLocal: true)
            .then((response) {

              print('RESPONSE $response');
              if (response != 1) {
                print('Showing error');
                showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(FlutterI18n.translate(context, 'troubleshooting.missing_files.title')),
                      content: SingleChildScrollView(
                        child: Text(FlutterI18n.translate(context, 'troubleshooting.missing_files.solution_one'))
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
            })
            .catchError((error) => print(error));
          },
          
          palabra: singlePalabra,
          model: model,
        );
      },
    );
  }
}