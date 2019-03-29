// import 'package:flutter/material.dart';
// import 'package:moblie/model/main.dart';
// import 'package:moblie/model/palabra.model.dart';
// import 'package:moblie/widgets/palabras/palabras.card.dart';
// import 'package:scoped_model/scoped_model.dart';

// class Palabras extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<MainModel>(
//       builder: (BuildContext context, Widget child, MainModel model) =>
//         _buildPalabrasList(model.allPalabras, model)
//     );
//   }

//   Widget _buildPalabrasList(List<Palabra> palabras, MainModel model) {

//     Widget palabrasCard;

//     if (palabras.length > 0) {
//       palabrasCard = ListView.builder(
//         itemCount: palabras.length,
//         itemBuilder: (BuildContext context, int index) {
//           return PalabraCard(palabras[index]);
//         }
//       );
//     }

//     return palabrasCard;
//   }
// }