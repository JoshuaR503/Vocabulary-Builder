import 'package:flutter/material.dart';

import '../../pages/palabra-single-screen.dart';
import '../../model/palabra.model.dart';
import '../../model/main.dart';
import '../../utils/settings.dart';

class PalabraCard extends StatefulWidget {

  final Palabra palabra;
  final MainModel model;
  final int index;
  
  PalabraCard(
    this.palabra, 
    this.model, 
    this.index
  );

  @override
    State<StatefulWidget> createState() => _PalabraCardState();
}

class _PalabraCardState extends State<PalabraCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context, MaterialPageRoute(
        builder: (_) => SinglePalabraScreen(widget.palabra, widget.model)
      )),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Card(
          child: Column(
            children: <Widget>[
              _buildDataRow(context),
              _buildActionButtons(context)
            ],
          ),
        ),
      )
    );
  } 

  Widget _buildDataRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      height: 130.0,

      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButtonBar(context),
            SizedBox(height: 2.0),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(widget.palabra.traduccion),
            )
          ],
        ),
      )
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 20.0, 
      fontWeight: FontWeight.w300
    );

    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              widget.palabra.palabra, 
              style: style
            ),
            
            IconButton(
              color: Colors.red,
              icon: Icon(Icons.favorite_border),
              onPressed: () =>_save(context, widget.palabra),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {

    TextStyle style = TextStyle(
      fontSize: 14.0, 
      fontWeight: FontWeight.w300
    );

    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () => widget.model.speak(widget.palabra.palabra),   
          child: Row(
            children: <Widget>[
              Padding(
                child: Text(buttonName, style: style),
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

    await widget.model
    .save(palabraData: palabra)
    .then((response) {
      if (response != 0) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(onSuccessMessage)));
      }
    })
    .catchError((error) => Scaffold.of(context).showSnackBar(SnackBar(content: Text(onErrorMessage))));
  }
}