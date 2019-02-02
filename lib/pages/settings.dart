import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return WillPopScope(
      
      onWillPop: () {
        Navigator.pop(context, false);
      },
      
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configuración'),
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