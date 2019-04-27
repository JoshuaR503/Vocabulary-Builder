import 'package:flutter/material.dart';
import 'package:vocabulary_builder/model/main.dart';
import 'package:vocabulary_builder/model/palabra.model.dart';
import 'package:vocabulary_builder/utils/colors.dart';
import 'package:vocabulary_builder/widgets/ui/elements/slim-card.dart';
import 'package:scoped_model/scoped_model.dart';

class PalabraGuardadaCard extends StatelessWidget {
  final Palabra palabra;

  PalabraGuardadaCard(this.palabra);

  Widget build(BuildContext context) {

    Palabra singlePalabra =  Palabra(
      palabra: palabra.palabra,
      traduccion: palabra.traduccion,
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
          title: singlePalabra.palabra,
          subtitle: singlePalabra.traduccion,

          firstAvatar: CircleAvatar(
		      	backgroundColor: yellowAmbarColor,
		      	child: Icon(Icons.volume_up, color: Colors.white),
		      ),

          secondtAvatar: CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.info_outline, color: Colors.white),
          ),

          firstFunction: () {
            model.speak(
              model.userLang == 'en' 
                ? singlePalabra.traduccion
                : singlePalabra.palabra
            );
          },
          
          palabra: singlePalabra,
          model: model,
        );
      },
    );
  }
}