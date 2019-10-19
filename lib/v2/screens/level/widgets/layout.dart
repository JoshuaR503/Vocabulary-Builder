import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void _onTap(String level, BuildContext context) {
    BlocProvider
      .of<ConfigBloc>(context)
      .dispatch(LevelChangedEvent(config: level));

    Navigator
    .of(context)
    .pushNamed('/');
  }

  Widget _buildVerticalLayout(double targetWidth, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
      
        children: <Widget>[
        
          LevelTitle(),
          
          SizedBox(height: targetWidth / 10),
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Button('Beginner', () => _onTap('easy', context), 480),
              Button('Experienced', () => _onTap('normal', context), 480),
            ],
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: targetWidth / 20),
            child: Button("Doesn't matter", () => _onTap('all', context), targetWidth),
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
              Button('Beginner', () => _onTap('easy', context), targetWidth),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Button('Experienced', () => _onTap('normal', context), targetWidth),
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
