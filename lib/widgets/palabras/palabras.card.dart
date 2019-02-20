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
        MaterialPageRoute(builder: (_) => SinglePalabraScreen(palabra, model)),
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
                  Row(
                    children: <Widget>[
                      Padding(
                        child: Text(palabra.palabra, style: style),
                        padding: EdgeInsets.only(left: 12.0),
                      ),
                      IconButton(
                        onPressed: () => _save(context, palabra),
                        icon: Icon(Icons.favorite_border),
                        color: Colors.red,
                      ),
                    ],
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

  void _save(BuildContext context, Palabra palabra) async {

    await model
    .save(palabraData: palabra)
    .then((response) {
      if (response != 0) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(onSuccessMessage)));
      }
      
    }).catchError((error) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(onErrorMessage)));
    });
  }
}