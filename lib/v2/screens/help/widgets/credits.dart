
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';

import 'package:vocabulary_builder/v2/widgets/text/index.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';
import 'package:vocabulary_builder/v2/widgets/ui/index.dart';

class CreditsTab extends StatelessWidget {

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
        children: <Widget>[

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'credits.developer.title')),
              ListCell(
                title: FlutterI18n.translate(context, 'credits.developer.title_two'),
                subtitle: FlutterI18n.translate(context, 'credits.developer.subtitle'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.paypal.me/JoshuaG503?locale.x=en_US'),              
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'credits.content.title')),
              ListCell(
                title: FlutterI18n.translate(context, 'credits.content.title_two'),
                subtitle: FlutterI18n.translate(context, 'credits.content.subtitle'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://giphy.com'),              
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'credits.icon_designer_one.title')),
              CommonSubtitle(FlutterI18n.translate(context, 'credits.icon_designer_one.subtitle')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/running-man.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'credits.icon_designer_one.title_two'),
                subtitle: FlutterI18n.translate(context, 'credits.icon_designer_one.subtitle_two'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/mynamepong'),
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'credits.icon_designer_two.title')),
              CommonSubtitle(FlutterI18n.translate(context, 'credits.icon_designer_two.subtitle')),
              ListCell(
                title: FlutterI18n.translate(context, 'credits.icon_designer_two.title_two'),
                subtitle: FlutterI18n.translate(context, 'credits.icon_designer_two.subtitle_two'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/freepik')
              ),
            ]
          )
        ]
      ),
    );
  }
}