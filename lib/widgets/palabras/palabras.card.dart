import 'package:flutter/material.dart';

import '../../pages/palabra-single-screen.dart';
import '../../model/palabra.model.dart';
import '../../model/main.dart';
import '../../utils/settings.dart';

class PalabraCard extends StatelessWidget {
  final Palabra palabra;
  final MainModel model;
  
  PalabraCard(this.palabra, this.model);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SinglePalabraScreen(palabra)),
      ),

      child: Card(
        child: Column(
          children: <Widget>[
            _buildDataRow(context),
            _buildActionButtons(context)
          ],
        ),
      )
    );
  } 

  Widget _buildDataRow(BuildContext context) {

    TextStyle style = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300);

    return Container(
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
                    onPressed: () => _save(context),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          child: Text(palabra.palabra, style: style),
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
          onPressed: () => model.speak(palabra.palabra),   
          child: Row(
            children: <Widget>[
              Padding(
                child: Text(
                  buttonName,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300),
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

  void _save(BuildContext context) async {

    await model.save(
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
      tipo: palabra.tipo
    )
    .then((response) {
      if (response != 0) 
      
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(onSuccessMessage)));
      
    }).catchError((error) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(onErrorMessage)));
    });
  }
}