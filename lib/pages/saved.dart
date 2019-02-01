import 'package:flutter/material.dart';

import '../model/main.dart';


class SavedScreen extends StatefulWidget {

  // final MainModel model;

  // SavedScreen(this.model);

  @override
  State<StatefulWidget> createState() => _SavedScreen();
}

class _SavedScreen extends State<SavedScreen> { 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      
      onWillPop: () {
        Navigator.pop(context);
      },

      child: Scaffold(
        appBar: AppBar(
          title: Text('Palabras Guardadas'),
          centerTitle: true,
        ),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[

            ],
          )
        ),
      )
    );
  }
}