import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/word/word_repository.dart';

import 'package:vocabulary_builder/v2/screens/word/widgets/word_about.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/word_conjugation.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/word_examples.dart';
import 'package:vocabulary_builder/v2/widgets/components/reusable/question.dart';

class WordScreen extends StatefulWidget {

  final Word word;

  const WordScreen({
    this.word,
  }) : assert(word != null);

  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<WordScreen> {

  final WordRepository _wordRepository = WordRepository();
  final List<Widget> _children = [];

  bool hasHartBeenTaped = false;

  @override
  void initState() {

    _children.add(WordAboutCard(word: this.widget.word));
    _children.add(WordExamplesCard(word: this.widget.word));

    if (
      this.widget.word.targetLanguage.root != null && 
      this.widget.word.firstLanguage.root != null
    ) _children.add(WordConjugationCard(word: this.widget.word,));
    
    super.initState();
  }

  // Helpers
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

  void _changeScreen() {
    BlocProvider
        .of<WordBloc>(context)
        .add(InsertWordEvent());

    Navigator
      .of(context)
      .pushNamed('/saved');
  }

  void _onPressedHandler(BuildContext context) async {

    // Save word hardCoded.
    final dynamic response = await _wordRepository.insertWord(word: this.widget.word);

    if (response != null) {
      final String message = FlutterI18n.translate(context, 'word.snackbar.success.text');
      final SnackBarAction action = SnackBarAction(
        label: FlutterI18n.translate(context, 'word.snackbar.success.action'),
        textColor: Colors.amber,
        onPressed: _changeScreen,
      );

      setState(() => hasHartBeenTaped = true);

      Scaffold
        .of(context)
        .showSnackBar(_buildSnackbar(action: action, message: message));

    } else if (!this.widget.word.isSaved) {
      final String message = FlutterI18n.translate(context, 'word.snackbar.fail.text');
      final SnackBarAction action = SnackBarAction(
        label: FlutterI18n.translate(context, 'word.snackbar.fail.action'),
        textColor: Colors.amber,
        onPressed: () {},
      );
      
      Scaffold
        .of(context)
        .showSnackBar(_buildSnackbar(action: action, message: message));
    }
  }

  Widget _renderRightIcon() {
    if (this.widget.word.isSaved || this.hasHartBeenTaped) {
      return Icon(Icons.bookmark);
    }

    return Icon(Icons.bookmark_border);
  }

  List<Widget> _buildActions() {
    return [
      Tooltip(
        message: FlutterI18n.translate(context, 'word.action'),
        child: Builder(
          builder: (context) => IconButton(
            icon: _renderRightIcon(),
            onPressed: () {
              if (!widget.word.isSaved || !hasHartBeenTaped) _onPressedHandler(context);
              if (widget.word.isSaved || hasHartBeenTaped) return null;
            }
          )
        )
      ),
    ];
  }
  
  // Actual Widgets
  @override
  Widget build(BuildContext context) {

    final bool hasVerbs = 
      this.widget.word.targetLanguage.root != null && 
      this.widget.word.firstLanguage.root != null;

    final bool hasConjugation = 
      this.widget.word.targetLanguage.root != null &&
      this.widget.word.firstLanguage.root != null;

    final int tabsLength = hasVerbs ? 3 : 2;

    return DefaultTabController(
      length: tabsLength,
      child: Scaffold(
        backgroundColor: AppCardColors.backgroundCardColor,
        appBar: AppBar(
          backgroundColor: this.widget.word.color,
          title: Text(this.widget.word.targetLanguage.word),
          actions: _buildActions(),
          bottom: TabBar(
            indicatorWeight: 3,
            tabs: [

              Tab(text: FlutterI18n.translate(context, 'word.tabs.about')),
              Tab(text: FlutterI18n.translate(context, 'word.tabs.examples')),

              
              if (hasConjugation) Tab(text: FlutterI18n.translate(context, 'word.tabs.conjugation')),

            ]
          ),
        ),

        body: SafeArea(
          child: TabBarView(children: _children),
        ),

        floatingActionButton: QuestionIcon(initialIndex: 0)
      ),
    );
  }
}
