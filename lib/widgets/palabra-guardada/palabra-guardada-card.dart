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
            child: Icon(Icons.info_outline, color: Colors.white),
          ),

          firstFunction: () async {
            await model.checkInternetConnection();

            if (!model.internetConnected) {
              showDialog(
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
            } else {
              model.playAduio(
              url: model.userLang == 'en' 
                  ? 'https://vocabulary-polly-sound-files.s3.amazonaws.com/${singlePalabra.palabra}-${singlePalabra.traduccion}.mp3'
                  : 'https://vocabulary-polly-sound-files.s3.amazonaws.com/${singlePalabra.palabra}.mp3'
              );
            }
          },
          
          palabra: singlePalabra,
          model: model,
        );
      },
    );
  }
}