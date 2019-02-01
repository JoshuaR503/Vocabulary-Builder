import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment(0.0, -0.10),
                height: 100.0,
                child: Text(
                  'Palabras Guardadas',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black54
                  ),
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment(0.0, -0.10),
            child: Row(
              children: <Widget>[
                Text(
                  'Las palabras que seleciones apareceran aqui',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}