import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class SettingScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State<SettingScreen> {

  @override
    Widget build(BuildContext context) {
      return WillPopScope(

        onWillPop: () {
          Navigator.pop(context, true);
        },
        
        child: Scaffold(
          appBar: AppBar(
            title: Text('Configuración'),
            centerTitle: true,
          ),  
          body: Scrollbar(
            child: ListView(children: <Widget>[
              FlatButton(
                child: Text('Cambiar color'),
                onPressed: () {
                  DynamicTheme
                  .of(context)
                  .setBrightness(
                    Theme.of(context).brightness == 
                    Brightness.dark ? 
                    Brightness.light: 
                    Brightness.dark
                  );
                },
              )
            ])
          )
        )
      );
    }
}