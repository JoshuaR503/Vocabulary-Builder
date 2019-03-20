import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import 'package:moblie/utils/settings.dart';
import 'package:moblie/widgets/ui/list_cell.dart';
import 'package:moblie/widgets/ui/text/title.dart';

class QuestionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'question_answers.title')),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[

            CommonTitle(FlutterI18n.translate(context, 'question_answers.question_one.question')),
            ListCell(
              title: FlutterI18n.translate(context, 'question_answers.question_one.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.question_one.answer'),
              onTap: () {},
            ),

            CommonTitle(FlutterI18n.translate(context, 'question_answers.sentence.question')),
            ListCell(
              title: FlutterI18n.translate(context, 'question_answers.sentence.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.sentence.answer'),
              onTap: () {},
            ),

            CommonTitle(FlutterI18n.translate(context, 'question_answers.singular.question')),
            ListCell(
              leading: Image.asset(
                'assets/mushroom.png',
                height: 50.0,
                width: 50.0,
              ),
              title: FlutterI18n.translate(context, 'question_answers.singular.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.singular.answer'),
              onTap: () {},
            ),

            CommonTitle(FlutterI18n.translate(context, 'question_answers.plural.question')),
            ListCell(
              leading: Image.asset(
                'assets/tree.png',
                height: 50.0,
                width: 50.0,
              ),
              title: FlutterI18n.translate(context, 'question_answers.plural.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.plural.answer'),
              onTap: () {},
            ),

            CommonTitle(FlutterI18n.translate(context, 'question_answers.antonyms.question')),
            ListCell(
              title: FlutterI18n.translate(context, 'question_answers.antonyms.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.antonyms.answer'),
              onTap: () {},
            ),

            CommonTitle(FlutterI18n.translate(context, 'question_answers.synonyms.question')),
            ListCell(
              title: FlutterI18n.translate(context, 'question_answers.synonyms.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.synonyms.answer'),
              onTap: () {},
            ),

            CommonTitle(FlutterI18n.translate(context, 'question_answers.subject.question')),
            ListCell(
              leading: Image.asset(
                'assets/parrot.png',
                height: 50.0,
                width: 50.0,
              ),
              title: FlutterI18n.translate(context, 'question_answers.subject.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.subject.answer'),
              onTap: () {},
            ),

            CommonTitle(FlutterI18n.translate(context, 'question_answers.verb.question')),
            ListCell(
              leading: Image.asset(
                'assets/running-man.png',
                height: 50.0,
                width: 50.0,
              ),
              title: FlutterI18n.translate(context, 'question_answers.verb.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.verb.answer'),
              onTap: () {},
            ),

            CommonTitle(FlutterI18n.translate(context, 'question_answers.noun.question')),
            ListCell(
              leading: Image.asset(
                'assets/apple.png',
                height: 50.0,
                width: 50.0,
              ),
              title: FlutterI18n.translate(context, 'question_answers.noun.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.noun.answer'),
              onTap: () {},
            ),
            CommonTitle(FlutterI18n.translate(context, 'question_answers.adjective.question')),
            ListCell(
              leading: Image.asset(
                'assets/plant.png',
                height: 50.0,
                width: 50.0,
              ),
              title: FlutterI18n.translate(context, 'question_answers.adjective.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.adjective.answer'),
              onTap: () {},
            ),

            CommonTitle(FlutterI18n.translate(context, 'question_answers.adverb.question')),
            ListCell(
              leading: Image.asset(
                'assets/planet.png',
                height: 50.0,
                width: 50.0,
              ),
              title: FlutterI18n.translate(context, 'question_answers.adverb.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.adverb.answer'),
              onTap: () {},
            ),
            
            CommonTitle(FlutterI18n.translate(context, 'question_answers.not_found.question')),
            ListCell(
              leading: Image.asset(
                'assets/info.png',
                height: 50.0,
                width: 50.0,
              ),
              title: FlutterI18n.translate(context, 'question_answers.not_found.title'),
              subtitle: FlutterI18n.translate(context, 'question_answers.not_found.subtitle'),
              onTap: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback),
            ),
          ]
        )
      ),
    );
  }
}