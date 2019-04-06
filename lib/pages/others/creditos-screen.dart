import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'package:vocabulary_builder/utils/settings.dart';
import 'package:vocabulary_builder/widgets/ui/list_cell.dart';
import 'package:vocabulary_builder/widgets/ui/text/subtitle.dart';
import 'package:vocabulary_builder/widgets/ui/text/title.dart';

class CreditoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 850.0 : deviceWidth;

    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'credits.title')),
        centerTitle: true,
      ),  
      body: Center(
        child: Container(
          width: targetWidth,
          child: ListView(
            children: <Widget>[
              CommonTitle(FlutterI18n.translate(context, 'credits.developer.title')),
              ListCell(
                title: FlutterI18n.translate(context, 'credits.developer.title_two'),
                subtitle: FlutterI18n.translate(context, 'credits.developer.subtitle'),
                onTap: () async => await FlutterWebBrowser.openWebPage(url: authorEmail),
              ),

              CommonTitle(FlutterI18n.translate(context, 'credits.icon_designer_one.title')),
              SubTitle(FlutterI18n.translate(context, 'credits.icon_designer_one.subtitle')),
              ListCell(
                leading: Image.asset(
                  'assets/running-man.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'credits.icon_designer_one.title_two'),
                subtitle: FlutterI18n.translate(context, 'credits.icon_designer_one.subtitle_two'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/mynamepong'),
              ),

              CommonTitle(FlutterI18n.translate(context, 'credits.icon_designer_two.title')),
              SubTitle(FlutterI18n.translate(context, 'credits.icon_designer_two.subtitle')),
              ListCell(
                title: FlutterI18n.translate(context, 'credits.icon_designer_two.title_two'),
                subtitle: FlutterI18n.translate(context, 'credits.icon_designer_two.subtitle_two'),
                onTap: () => FlutterWebBrowser.openWebPage(url: 'https://www.flaticon.com/authors/freepik')
              ),
            ]
          )
        )
      )
    );
  }
}