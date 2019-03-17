import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:moblie/model/main.dart';
import 'package:moblie/utils/colors.dart';
import 'package:moblie/widgets/ui/divider.dart';
import 'package:scoped_model/scoped_model.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.4],
                colors: [
                  colorTopLeft,
                  colorButtonRight
                ],
              ),
            ),

            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: <Widget>[
              
                _renderText(
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),

                  title: FlutterI18n.translate(context, 'welcome_screen.title'),
                  margin: EdgeInsets.only(top: 150.0, bottom: 10.0, left:     20, right: 20),
                ),

                _renderText(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),

                  title: FlutterI18n.translate(context, 'welcome_screen.subtitle'),
                  margin: EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20,     right: 20)
                ),

                Separator.spacer(height: 20.0),
                _renderButton(
                  name: 'Inglés',
                  language: 'en',
                  model: model,
                  context: context
                ),

                Separator.spacer(height: 20.0),
                _renderButton(
                  name: 'Español',
                  language: 'es',
                  model: model,
                  context: context
                )
              ],
            ),
          )
        );
      },
    );
  }

  Widget _renderButton({String name, String language, model, context}) {
    return RaisedButton(
      color: transparent,
      child: Container(
        alignment: Alignment.center,
        child: Text(name),
        width: 200,
        height: 50,
      ),
      onPressed: () {
        model.setUserPreferedLanguage(language: language);

        Navigator.of(context).pushReplacementNamed('/intro');
      },
    );
  }

  Widget _renderText({String title, TextStyle style, EdgeInsetsGeometry margin}) {
    return Container(
      child: Text(
        title,
        style: style,
        textAlign: TextAlign.center,
      ),

      margin: margin,
    );
  }

}