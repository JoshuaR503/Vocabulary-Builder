import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './palabras.card.dart';
import '../../model/palabra.model.dart';
import '../../model/main.dart';

class Palabras extends StatelessWidget {
  
  Widget _buildPalabrasList(List<Palabra> palabras) {

    Widget palabrasCard;

    if (palabras.length > 0) {
      palabrasCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => PalabraCard(palabras[index]),
        itemCount: palabras.length,
      );
    } else {
      palabrasCard = Center(child: Text('No data found. :('));
    }

    return palabrasCard;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build()');
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) => _buildPalabrasList(model.allPalabras)
    );
  }
}