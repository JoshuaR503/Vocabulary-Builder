import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:meta/meta.dart';
import 'package:vocabulary_builder/v2/blocs/config/bloc.dart';

import 'package:vocabulary_builder/v2/screens/level/widgets/title.dart';
import 'package:vocabulary_builder/v2/widgets/components/button.dart';

class LevelLayout extends StatefulWidget {

  LevelLayout({
    @required this.layout
  }) : assert(layout != null);

  final String layout;

  @override
  _LevelLayoutState createState() => _LevelLayoutState();
}

class _LevelLayoutState extends State<LevelLayout> {
  
  // Helpers
  void _onTap(String level) {
    BlocProvider
      .of<ConfigBloc>(context)
      .add(LevelChangedEvent(config: level));

    Navigator
    .of(context)
    .popAndPushNamed('/home');
  }

  // Layouts
  Widget _buildVerticalLayout(double targetWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
      
        children: <Widget>[
        
          LevelTitle(),
          
          SizedBox(height: targetWidth / 10),

          Container(
            padding: EdgeInsets.symmetric(vertical: targetWidth / 50),
            child: Button(FlutterI18n.translate(context, 'level.options.beginner'), () => _onTap('easy'), 480),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: targetWidth / 50),
            child: Button(FlutterI18n.translate(context, 'level.options.experienced'), () => _onTap('normal'), 480),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: targetWidth / 50),
            child: Button(FlutterI18n.translate(context, 'level.options.any'), () => _onTap('all'), targetWidth),
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
        
          LevelTitle(),

          SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Button(FlutterI18n.translate(context, 'level.options.beginner'), () => _onTap('easy'), targetWidth),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Button(FlutterI18n.translate(context, 'level.options.experienced'), () => _onTap('normal'), targetWidth)
            ],
          ),

          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: targetWidth / 30),
                child: Button(FlutterI18n.translate(context, 'level.options.any'), () => _onTap('all'), targetWidth),
              )
            ],
          )
        ],
      ),
    );
  }

  // Actual W
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;

    if (widget.layout == 'horizontal') {
      return _buildHorizontalLayout(deviceWidth);
    } else {
      return _buildVerticalLayout(deviceWidth);
    }
  }
}
