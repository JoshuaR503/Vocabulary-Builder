import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:moblie/model/main.dart';
import 'package:moblie/utils/colors.dart';
import 'package:moblie/widgets/ui/text/title.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(

          appBar: AppBar(
            centerTitle: true,
            title: Text(FlutterI18n.translate(context, 'settings.title')),
          ),

          body: Column(
            children: <Widget>[
              CommonTitle(FlutterI18n.translate(context, 'settings.option_one')),

              ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  
                  RaisedButton(
                    color: transparent,
                    child: Text('Inglés'),
                    onPressed: () => model.setUserPreferedLanguage(language: 'en'),
                  ),

                  RaisedButton(
                    color: transparent,
                    child: Text('Spanish'),
                    onPressed: () => model.setUserPreferedLanguage(language: 'es'),
                  )
                ],
              ),
            ],
          )
        );
      },
    );
  }
}