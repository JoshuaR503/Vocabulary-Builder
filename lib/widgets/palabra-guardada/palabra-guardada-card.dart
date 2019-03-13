import 'package:flutter/material.dart';
import 'package:moblie/model/main.dart';
import 'package:moblie/model/palabra.model.dart';
import 'package:moblie/widgets/ui/elements/slim-card.dart';

class PalabraGuardadaCard extends StatelessWidget {
  final Palabra palabra;
  final MainModel model;

  PalabraGuardadaCard(this.palabra, this.model);

  Widget build(BuildContext context) {
    
    Palabra singlePalabra =  Palabra(
      palabra: palabra.palabra,
      traduccion: palabra.traduccion,
      pasado: palabra.pasado,
      presente: palabra.presente,
      presenteContinuo: palabra.presenteContinuo,
      thirdPerson: palabra.thirdPerson,
      futuro: palabra.futuro,
      definicion: palabra.definicion,
      definicionEs: palabra.definicionEs,
      sinonimos: palabra.sinonimos,
      antonimos: palabra.antonimos,
      ejemplos: palabra.ejemplos, 
      plural: palabra.plural,
      singular: palabra.singular,
      nota: palabra.nota,
      tipo: palabra.tipo,
    );

    return SlimCard(
      title: singlePalabra.palabra,
      subtitle: singlePalabra.traduccion,

      firstAvatar: CircleAvatar(
		  	backgroundColor: Colors.amber,
		  	child: Icon(Icons.volume_up, color: Colors.white),
		  ),

      secondtAvatar: CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(Icons.info_outline, color: Colors.white),
      ),

      firstFunction: () {
        model.speak(singlePalabra.palabra);
      },

      palabra: singlePalabra,
      model: model,
    );
  }
}