
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';
import 'package:vocabulary_builder/v2/widgets/text/index.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';
import 'package:vocabulary_builder/v2/widgets/ui/index.dart';

class QuestionsTab extends StatelessWidget {

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
              CommonTitle(FlutterI18n.translate(context, 'question_answers.question_one.question')),
              ListCell(
                title: FlutterI18n.translate(context, 'question_answers.question_one.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.question_one.answer'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.question_one_2.question')),
              ListCell(
                title: FlutterI18n.translate(context, 'question_answers.question_one_2.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.question_one_2.answer'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.noun.question')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/apple.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'question_answers.noun.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.noun.answer'),
                onTap: () {},
              ),
            ]
          ),

          

          

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.singular.question')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/mushroom.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'question_answers.singular.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.singular.answer'),
                onTap: () {},
              ),
            ]
          ),

           _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.plural.question')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/tree.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'question_answers.plural.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.plural.answer'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.antonyms.question')),
              ListCell(
                title: FlutterI18n.translate(context, 'question_answers.antonyms.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.antonyms.answer'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.synonyms.question')),
              ListCell(
                title: FlutterI18n.translate(context, 'question_answers.synonyms.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.synonyms.answer'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.subject.question')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/parrot.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'question_answers.subject.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.subject.answer'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.verb.question')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/running-man.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'question_answers.verb.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.verb.answer'),
                onTap: () {},
              ),
            ]
          ),

          

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.phasal_verbs.question')),
              ListCell(
                title: FlutterI18n.translate(context, 'question_answers.phasal_verbs.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.phasal_verbs.answer'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.idioms.question')),
              ListCell(
                title: FlutterI18n.translate(context, 'question_answers.idioms.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.idioms.answer'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.adjective.question')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/plant.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'question_answers.adjective.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.adjective.answer'),
                onTap: () {},
              ),
            ]
          ),

          _createCard(
            context: context,
            children: <Widget> [
              CommonTitle(FlutterI18n.translate(context, 'question_answers.adverb.question')),
              ListCell(
                leading: Image.asset(
                  'assets/pictures/planet.png',
                  height: 50.0,
                  width: 50.0,
                ),
                title: FlutterI18n.translate(context, 'question_answers.adverb.title'),
                subtitle: FlutterI18n.translate(context, 'question_answers.adverb.answer'),
                onTap: () {},
              ),
            ]
          ),

          // _createCard(
          //   context: context,
          //   children: <Widget> [
          //     CommonTitle(FlutterI18n.translate(context, 'question_answers.not_found.question')),
          //     ListCell(
          //       title: FlutterI18n.translate(context, 'question_answers.not_found.title'),
          //       subtitle: FlutterI18n.translate(context, 'question_answers.not_found.subtitle'),
          //       onTap: null
          //     ),
          //   ]
          // ),

          Separator.spacer(height: 12.0),
        ]
      ),
    );
  }
}