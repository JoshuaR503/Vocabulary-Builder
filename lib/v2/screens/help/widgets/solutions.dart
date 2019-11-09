
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';
import 'package:vocabulary_builder/v2/widgets/text/index.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';
import 'package:vocabulary_builder/v2/widgets/ui/index.dart';

class SolutionsTab extends StatelessWidget {

  Widget _createCard({BuildContext context, List<Widget> children}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: WordDataCard(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
      child: ListView(
        children: <Widget> [

          // _createCard(
          //   context: context, 
          //   children: <Widget>[
          //     CommonTitle(FlutterI18n.translate(context, 'troubleshooting.no_server.title')),
          //     CommonSubtitle(FlutterI18n.translate(context, 'troubleshooting.no_server.subtitle')),
          //     ListCell(
          //       leading: Image.asset(
          //         'assets/pictures/limit.png',
          //         height: 50.0,
          //         width: 50.0,
          //       ),
          //       title: FlutterI18n.translate(context, 'troubleshooting.no_server.response_one'),
          //       subtitle: FlutterI18n.translate(context, 'troubleshooting.no_server.solution_one'),
          //       onTap: () {},
          //     ),
          //   ]
          // ),

          _createCard(
            context: context, 
            children: <Widget>[
              CommonTitle(FlutterI18n.translate(context, 'troubleshooting.missing_files.title')),
              CommonSubtitle(FlutterI18n.translate(context, 'troubleshooting.missing_files.subtitle')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/archive.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'troubleshooting.missing_files.response_one'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.missing_files.solution_one'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context, 
            children: <Widget>[
              CommonTitle(FlutterI18n.translate(context, 'troubleshooting.no_words.title')),
              CommonSubtitle(FlutterI18n.translate(context, 'troubleshooting.no_words.subtitle')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/wifi.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'troubleshooting.no_words.response_one'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.no_words.solution_one'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context, 
            children: <Widget>[
              CommonTitle(FlutterI18n.translate(context, 'troubleshooting.voice.title')),
              CommonSubtitle(FlutterI18n.translate(context, 'troubleshooting.voice.subtitle')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/angry.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'troubleshooting.voice.response_one'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.voice.solution_one'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context, 
            children: <Widget>[
              CommonTitle(FlutterI18n.translate(context, 'troubleshooting.no_volume.title')),
              CommonSubtitle(FlutterI18n.translate(context, 'troubleshooting.no_volume.subtitle')),
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
            ]
          ),

          _createCard(
            context: context, 
            children: <Widget>[
              ListCell(
                title: FlutterI18n.translate(context, 'troubleshooting.no_volume.response_four'),
                subtitle: FlutterI18n.translate(context, 'troubleshooting.no_volume.solution_four'),
                onTap: () {},
              ),
            ]
          ),

          Separator.spacer(height:10.0),
        ]
      ),
    );
  }
}
