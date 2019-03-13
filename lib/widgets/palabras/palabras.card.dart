import 'package:flutter/material.dart';
import 'package:moblie/model/main.dart';
import 'package:moblie/model/palabra.model.dart';
import 'package:moblie/pages/palabra-single-screen.dart';
import 'package:moblie/utils/settings.dart';
import 'package:scoped_model/scoped_model.dart';

class PalabraCard extends StatelessWidget {
  final Palabra palabra;
  
  PalabraCard(this.palabra);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant <MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SinglePalabraScreen(palabra))),
          child: Card(
            child: Column(
              children: <Widget>[
                _buildDataRow(context, model),
                _buildActionButtons(context, model)
              ],
            ),
          )
        );
      }
    );
  }

  Widget _buildDataRow(BuildContext context, MainModel model) {

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
                        padding: EdgeInsets.only(left: 16.0),
                      ),
                      IconButton(
                        onPressed: () => _save(context, palabra, model),
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

  Widget _buildActionButtons(BuildContext context, MainModel model) {
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

  void _save(BuildContext context, Palabra palabra, MainModel model) async {
    await model
    .save(palabraData: palabra)
    .then((response) {
      if (response != 0) {
         _createSnackBar(
          title: onSuccessMessage,
          label: 'Ok!',
          context: context
        );

        model.sendFeedback(false);
      }
    })
    .catchError((error) {
      _createSnackBar(
        title: onErrorMessage,
        label: 'Ok!',
        context: context
      );

      model.sendFeedback(true);
    }); 
  }

  void _createSnackBar({String title, String label, BuildContext context}) {
    final snackBar = SnackBar(
      content: Text(title),
      action: SnackBarAction(
        label: label,
        onPressed: () {},
      ),
    );
    
    Scaffold.of(context).showSnackBar(snackBar);
  }
}