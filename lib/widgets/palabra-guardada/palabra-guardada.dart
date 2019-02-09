import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './palabra-guardada-card.dart';
import '../../utils/settings.dart';
import '../../model/palabra_guardada.model.dart';
import '../../model/main.dart';

class PalabrasGuardadas extends StatelessWidget {

  @override
  Widget build(BuildContext context) => ScopedModelDescendant<MainModel> (
    builder: (BuildContext context, Widget child, MainModel model) => _buildPalabrasList(model.allPalabrasGuardadas, model, context));

  Widget _buildPalabrasList(List<PalabraGuardada> palabras, MainModel model, BuildContext context) {

    Widget palabrasCard;

    if (palabras.length > 0) {
      palabrasCard = ListView.builder(
        itemCount: palabras.length,
        itemBuilder: (BuildContext context, int index)  {

          return Dismissible(
            key: Key(palabras[index].palabra),
            background: _renderBackground(),
            onDismissed: (DismissDirection direction) {
              model.selectPalabra(model.allPalabrasGuardadas[index].id);
              model.deletePalabraGuardada();
            },
            
            child: PalabraGuardadaCard(palabras[index], model)
          );
        },
      );
    } else {
      palabrasCard = Center(child: Text(onSavedWordsError));
    }

    return palabrasCard;
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