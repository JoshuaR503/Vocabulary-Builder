
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/widgets/components/reusable/question.dart';
import 'package:vocabulary_builder/v2/widgets/text/index.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';
import 'package:vocabulary_builder/v2/widgets/ui/index.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.defaultBlack,
        title: Text(FlutterI18n.translate(context, 'settings.section_title')),
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: SafeArea(
          child: SimpleContainer(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[

                CommonTitle(FlutterI18n.translate(context, 'settings.send_feedback.title')),
                ListCell(
                  title: FlutterI18n.translate(context, 'settings.send_feedback.message'),
                  subtitle: FlutterI18n.translate(context, 'settings.send_feedback.subtitle'),
                  onTap: () => Navigator.of(context).pushNamed('/feedback'),
                ),

                CommonTitle(FlutterI18n.translate(context, 'settings.change_language.title')),
                ListCell(
                  title: FlutterI18n.translate(context, 'settings.change_level.message'),
                  subtitle: FlutterI18n.translate(context, 'settings.change_level.subtitle'),
                  onTap: () => Navigator.of(context).pushNamed('/language'),

                ),
              ],
            ),
          )
        )
      ),

      floatingActionButton: QuestionIcon(
        initialIndex: 2,
      )
    );
  }
}