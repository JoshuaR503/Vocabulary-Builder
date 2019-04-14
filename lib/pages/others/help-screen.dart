import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vocabulary_builder/widgets/ui/list_cell.dart';
import 'package:vocabulary_builder/widgets/ui/text/subtitle.dart';
import 'package:vocabulary_builder/widgets/ui/text/title.dart';

class HelpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 850.0 : deviceWidth;

    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'troubleshooting.title')),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.0),
          width: targetWidth,
          child: ListView(
            children: <Widget>[

              CommonTitle(FlutterI18n.translate(context, 'troubleshooting.no_words.title')),
              SubTitle(FlutterI18n.translate(context, 'troubleshooting.no_words.subtitle')),
              ListCell(
                leading: Image.asset(
                  'assets/wifi.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'troubleshooting.no_words.response_one'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.no_words.solution_one'),
                onTap: () {},
              ),

              CommonTitle(FlutterI18n.translate(context, 'troubleshooting.voice.title')),
              SubTitle(FlutterI18n.translate(context, 'troubleshooting.voice.subtitle')),
              ListCell(
                leading: Image.asset(
                  'assets/angry.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'troubleshooting.voice.response_one'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.voice.solution_one'),
                onTap: () {},
              ),
              CommonTitle(FlutterI18n.translate(context, 'troubleshooting.no_volume.title')),
              SubTitle(FlutterI18n.translate(context, 'troubleshooting.no_volume.subtitle')),

              ListCell(
                title: FlutterI18n.translate(context, 'troubleshooting.no_volume.response_one'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.no_volume.solution_one'),
                onTap: () {},
              ),
              ListCell(
                title: FlutterI18n.translate(context, 'troubleshooting.no_volume.response_two'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.no_volume.solution_two'),
                onTap: () {},
              ),

              ListCell(
                title: FlutterI18n.translate(context, 'troubleshooting.no_volume.response_three'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.no_volume.solution_three'),
                onTap: () {},
              ),
              ListCell(
                title: FlutterI18n.translate(context, 'troubleshooting.no_volume.response_four'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.no_volume.solution_four'),
                onTap: () {},
              ),

              
            ]
          ),
        )
      )
    );
  }
}