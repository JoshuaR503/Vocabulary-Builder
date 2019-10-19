import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vocabulary_builder/v2/blocs/config/bloc.dart';

import 'package:vocabulary_builder/v2/screens/language/widgets/title.dart';

import 'package:vocabulary_builder/v2/widgets/components/button.dart';

class LanguageLayout extends StatefulWidget {

  LanguageLayout({
    @required this.layout
  }) : assert(layout != null);

  final String layout;

  @override
  _LanguageLayoutState createState() => _LanguageLayoutState();
}

class _LanguageLayoutState extends State<LanguageLayout> {
  void _onTap(String language, BuildContext context) {
    BlocProvider
      .of<ConfigBloc>(context)
      .dispatch(LanguageChangedEvent(config: language));
      
    Navigator
    .of(context)
    .pushNamed('/');
  }

  Widget _buildVerticalLayout(double targetWidth, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
      
        children: <Widget>[
        
          LanguageTitle(),
          
          SizedBox(height: targetWidth / 10),
  
          Container(
            padding: EdgeInsets.symmetric(vertical: targetWidth / 50),
            child: Button('English', () => _onTap('en', context), targetWidth),
          ),
  
          Container(
            padding: EdgeInsets.symmetric(vertical: targetWidth / 50),
            child: Button('Spanish', () => _onTap('es', context), targetWidth),
          )
        ],
      ),
    );
  }

  Widget _buildHorizontalLayout(double targetWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80),
      child: ListView(
        children: <Widget>[
        
          LanguageTitle(),

          SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Button('English', null, targetWidth),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Button('Spanish', null, targetWidth),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 650.0 : deviceWidth;

    if (widget.layout == 'horizontal') {
      return _buildHorizontalLayout(targetWidth);
    } else {
      return _buildVerticalLayout(targetWidth, context);
    }
  }
}
