import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_data_card.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';

class WordAboutCard extends StatelessWidget {

  final Word word;
  final VocabularyBuilderFunctions functions = VocabularyBuilderFunctions();

  WordAboutCard({
    this.word
  }) : assert(word != null);

  // Methods
  void _playAudio({String audio}) {
    functions.playAudio(audio: audio);
  }

  String _findDefinition({String category, BuildContext context}) {
    switch (category) {
      case 'noun':
        return 
        FlutterI18n.translate(context, 'word.about_section.category.noun') +
        FlutterI18n.translate(context, 'question_answers.noun.answer');

      case 'verb':
        return 
        FlutterI18n.translate(context, 'word.about_section.category.verb') +
        FlutterI18n.translate(context, 'question_answers.verb.answer');

      case 'adjective':
        return 
        FlutterI18n.translate(context, 'word.about_section.category.adjective') +
        FlutterI18n.translate(context, 'question_answers.adjective.answer');

      case 'adverb':
        return 
        FlutterI18n.translate(context, 'word.about_section.category.adverb') +
        FlutterI18n.translate(context, 'question_answers.adverb.answer');

      case 'phrasal verb':
        return 
        FlutterI18n.translate(context, 'word.about_section.category.phrasal_verbs') +
        FlutterI18n.translate(context, 'question_answers.phasal_verbs.answer');

      case 'idiom':
        return 
        FlutterI18n.translate(context, 'word.about_section.category.idioms') +
        FlutterI18n.translate(context, 'question_answers.idiom.answer');

      default:
        return 'Unknown';
    }
  }

  // Helpers
  Widget _buildCard({Widget child}) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: child,
      ),
    );
  }

  Widget _buildSection({List<Widget> children}) {

    final Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
    );

    return _buildCard(child: child);
  }

  // Actual Widgets.
  Widget _buildFirstCard(BuildContext context) {
    return WordCard(
      word: this.word.en.word,
      definition: this.word.en.definition,
      onPressed: () => _playAudio(audio: this.word.en.wordPronuntiation),
    );
  }

  Widget _buildSecondCard(BuildContext context) {
    return WordCard(
      word: this.word.es.word,
      definition: this.word.es.definition,
      onPressed: () => _playAudio(audio: this.word.es.wordPronuntiation),
    );
  }

  Widget _buildCategorySection(BuildContext context) {

    final Text title = Text(
      FlutterI18n.translate(context, 'word.about_section.gramatical_category'),
      style: TextStyles.titleStyle
    );

    final Text definition = Text(
      _findDefinition(
        context: context,
        category: word.en.category
      ),

      style: TextStyles.definitionStyle,
    );

    final List<Widget> children = <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 30, left: 30, top: 25, bottom: 5),
        child: title
      ),
      Padding(
        padding: EdgeInsets.only(right: 30, left: 30, top: 5, bottom: 30),
        child: definition
      )
    ];

    return _buildSection(children: children);
  }

  Widget _buildNoteSection(BuildContext context) {

    final Text title = Text(
      FlutterI18n.translate(context, 'word.about_section.note'),
      style: TextStyles.titleStyle
    );

    final Text definition = Text(
      this.word.en.note,
      style: TextStyles.definitionStyle,
    );

    final List<Widget> children = <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 30, left: 30, top: 25, bottom: 10),
        child: title
      ),
      Padding(
        padding: EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 25),
        child: definition
      )
    ];

    return _buildSection(children: children);
  }

  @override
  Widget build(BuildContext context) {

    return SimpleContainer(
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
              SizedBox(height: 15),
              _buildFirstCard(context),

              SizedBox(height: 5),
              _buildSecondCard(context),

              if (word.en.note != null && word.en.note.length > 1) SizedBox(height: 5),
              if (word.en.note != null && word.en.note.length > 1) _buildNoteSection(context),

              SizedBox(height: 5),
              _buildCategorySection(context),

              SizedBox(height: 40),
            ],
          ),
        ],
      )
    );
  }
}
