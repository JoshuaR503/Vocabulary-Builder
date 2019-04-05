import 'package:flutter/material.dart';
import 'package:vocabulary_builder/model/main.dart';
import 'package:vocabulary_builder/model/palabra.model.dart';
import 'package:vocabulary_builder/widgets/palabra-guardada/palabra-guardada-card.dart';
import 'package:scoped_model/scoped_model.dart';

class PalabrasGuardadas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildPalabrasList(model.allPalabrasGuardadas, model, context);
      }
    );
  }

  Widget _buildPalabrasList( List<Palabra> palabras,  MainModel model,  BuildContext context ) {

    return ListView.builder(
      itemCount: palabras.length,
      itemBuilder: (BuildContext context, int index)  {
        return Dismissible(
          key: Key(palabras[index].palabra),
          background: _renderBackground(),
          onDismissed: (DismissDirection direction) {
            model.selectPalabra(model.allPalabrasGuardadas[index].id);
            model.deletePalabraGuardada();
          }, 
          
          child: PalabraGuardadaCard(palabras[index])
        );
      },
    );
  }

  Widget _renderBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}