import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/model/main.dart';

import 'package:scoped_model/scoped_model.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 650.0 : deviceWidth;

    final Orientation orientation = MediaQuery.of(context).orientation;

    return ScopedModelDescendant<MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          body: Center(
            child: Container(
              width: targetWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 120, left: 20.0, right: 20.0),
                          child: Text(FlutterI18n.translate(context, 'welcome_screen.title'),
                            style: TextStyle(
                              fontSize: 50.0, 
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),
                  ),

                  orientation == Orientation.portrait ? 
                    Container(
                      padding: EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          _renderButton(
                            name: 'Spanish',
                            language: 'en',
                            model: model,
                            context: context
                          ),
                          SizedBox(height: 20.0),
                          _renderButton(
                            name: 'Inglés',
                            language: 'es',
                            model: model,
                            context: context
                          ),
                        ],
                      ),
                    )

                  : Container(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _renderButton(
                          name: 'Inglés',
                          language: 'es',
                          model: model,
                          context: context
                        ),
                        _renderButton(
                          name: 'Inglés',
                          language: 'es',
                          model: model,
                          context: context
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          )
          
          
        );
      },
    );
  }

  Widget _renderButton({String name, String language, model, context}) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 260.0 : deviceWidth * 0.85;

    return GestureDetector(
      onTap: () {
        model.setLang(language).then((_) async => {
          await model.obtenerData(),
          await model.seen
            ? Navigator.pushReplacementNamed(context, '/home')
            : Navigator.pushReplacementNamed(context, '/intro')
        });
      },

      child: Container(
        height: 52.0,
        width: targetWidth,
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xFFFFBC02D),
          elevation: 7.0,
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize:20.0, 
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato'
              ),
            ),
          ),
        )
      ),
    );
  }
}