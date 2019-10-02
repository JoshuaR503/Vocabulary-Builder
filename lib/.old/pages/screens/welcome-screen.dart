import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vocabulary_builder/model/main.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double targetWidth = deviceWidth > 768.0 ? 650.0 : deviceWidth;
  
    return ScopedModelDescendant<MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          body: ListView(
            children: <Widget>[
              Container(
                width: targetWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: height / 6, left: 20.0, right: 20.0),
                            child: Text(FlutterI18n.translate(context, 'welcome_screen.title'),
                              style: TextStyle(
                                fontSize: 48.0,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    orientation == Orientation.portrait ? 
                      Container(
                        padding: EdgeInsets.only(top:  height / 10, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            _renderButton(
                              name: FlutterI18n.translate(context, 'welcome_screen.en'),
                              language: 'es',
                              model: model,
                              context: context
                            ),
                            SizedBox(height: 15.0),
                            _renderButton(
                              name: FlutterI18n.translate(context, 'welcome_screen.es'),
                              language: 'en',
                              model: model,
                              context: context
                            ),
                          ],
                        ),
                      )
                    : Container(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
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
                            name: 'Spanish',
                            language: 'en',
                            model: model,
                            context: context
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        );
      },
    );
  }

  Widget _renderButton({String name, String language, model, context}) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 260.0 : deviceWidth * 0.95;

    return GestureDetector(
      onTap: () => 

        model
        .setLang(language)
        .then((_) async => await model.seen
            ? Navigator.pushReplacementNamed(context, '/home')
            : Navigator.pushReplacementNamed(context, '/intro')),

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