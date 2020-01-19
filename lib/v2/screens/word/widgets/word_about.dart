import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/help/help.dart';

import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_data_card.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';

class WordAboutCard extends StatefulWidget {

  final Word word;

  WordAboutCard({
    @required this.word,
  }) : assert(word != null);

  @override
  _WordAboutCardState createState() => _WordAboutCardState();
}

class _WordAboutCardState extends State<WordAboutCard> {
  bool _isPlaying = false;
  bool _isButtonDisabled = false;

  void _changeState(bool value) {
    setState(() {
       _isPlaying = value;
      _isButtonDisabled = value; 
    });
  }

  void callbackManager() {
    Timer(Duration(milliseconds: 800), () => _changeState(false));
  }

  final VocabularyBuilderFunctions functions = VocabularyBuilderFunctions();

  Widget _buildSnackbar({SnackBarAction action, String message}) {
    final Text content = Text(
      message,
      style: TextStyle(
        color: Colors.white
      ),
    );

    return SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: AppColors.snackBar,
      content: content,
      action: action
    );
  }

  void _playAudio({String audio, bool isLocal, BuildContext context}) async {
    final int result = await functions
    .playAudio(
      audio: audio, 
      isLocal: isLocal
    )
    .then((result) {
      callbackManager();

      return result;
    });

    if (result == 0) {
      final String message = FlutterI18n.translate(context, 'word.snackbar.audio_error.text');
      final SnackBarAction action = SnackBarAction(
        label: FlutterI18n.translate(context, 'word.snackbar.audio_error.action'),
        textColor: Colors.amber,
        onPressed: () => 
        Navigator
        .of(context)
        .push(MaterialPageRoute(
          builder: (context) => HelpScreen(color: AppColors.red, initialIndex: 1)
        )),
      );

      Scaffold
      .of(context)
      .showSnackBar(_buildSnackbar(action: action, message: message));
    }
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
        FlutterI18n.translate(context, 'word.about_section.category.phasal_verb') +
        FlutterI18n.translate(context, 'question_answers.phasal_verbs.answer');

      case 'idiom':
        return 
        FlutterI18n.translate(context, 'word.about_section.category.idiom') +
        FlutterI18n.translate(context, 'question_answers.idioms.answer');

      default:
        return category;
    }
  }

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

  Widget _buildFirstCard(BuildContext context) {
    final bool hasDefinition = 
    this.widget.word.targetLanguage.definition != null && 
    this.widget.word.targetLanguage.definition.length > 1;

    final String definition = hasDefinition 
    ? this.widget.word.targetLanguage.definition.trim()
    : FlutterI18n.translate(context, 'word.about_section.no_data');

    return WordCard(
      word: this.widget.word.targetLanguage.word,
      definition: definition,
      onPressed: _isButtonDisabled ? () {} : () {
        if (!_isPlaying) {
          _changeState(true);
          _playAudio(
            audio: this.widget.word.targetLanguage.wordPronuntiation, 
            isLocal: this.widget.word.isSaved, 
            context: context
          );
        }
      }
    );
  }

  Widget _buildSecondCard(BuildContext context) {
    final bool hasDefinition = this.widget.word.firstLanguage.definition != null;

    final String definition = hasDefinition
    ? this.widget.word.firstLanguage.definition.trim()
    : FlutterI18n.translate(context, 'word.about_section.no_data');

    return WordCard(
      word: this.widget.word.firstLanguage.word,
      definition: definition,
      onPressed: _isButtonDisabled ? () {} : () {
        if (!_isPlaying) {

          print(this.widget.word.isSaved);

          _changeState(true);
          _playAudio(
            audio: this.widget.word.firstLanguage.wordPronuntiation, 
            isLocal: this.widget.word.isSaved, 
            context: context
          );
        }
      }
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
        category: widget.word.targetLanguage.category
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
      this.widget.word.targetLanguage.note,
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

    final bool hasNote = 
    widget.word.targetLanguage.note != null &&
    widget.word.firstLanguage.note != null

    && widget.word.firstLanguage.note.length > 1 
    && widget.word.targetLanguage.note.length > 1;

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

              if (hasNote) SizedBox(height: 5),
              if (hasNote) _buildNoteSection(context),

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
