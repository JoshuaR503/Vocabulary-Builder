import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/word/word_repository.dart';
import 'package:vocabulary_builder/v2/screens/help/help.dart';

import 'package:vocabulary_builder/v2/screens/word/widgets/word_about.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/word_conjugation.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/word_examples.dart';

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

  @override
  void initState() {
    _children.add(WordAboutCard(word: this.widget.word));
    _children.add(WordExamplesCard(word: this.widget.word));

    if (
      this.widget.word.en.root != null && 
      this.widget.word.es.root != null
    ) {
      _children.add(WordConjugationCard(word: this.widget.word));
    }

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

      Scaffold
        .of(context)
        .showSnackBar(_buildSnackbar(action: action, message: message));

    } else {
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

  List<Widget> _buildActions() {
    return [
      Tooltip(
        message: FlutterI18n.translate(context, 'word.action'),
        child: Builder(
          builder: (context) => IconButton(
            icon: this.widget.word.isSaved 
            ? Icon(Icons.favorite) 
            : Icon(Icons.favorite_border),
            
            onPressed: () {
              if (!widget.word.isSaved) _onPressedHandler(context);
              if (widget.word.isSaved) return null;
            }
          )
        )
      ),
    ];
  }
  
  // Actual Widgets
  @override
  Widget build(BuildContext context) {

    final bool hasVerbs = this.widget.word.en.root != null && this.widget.word.es.root != null;
    final int tabsLength = hasVerbs
    ? 3
    : 2;

    return DefaultTabController(
      length: tabsLength,
      child: Scaffold(
        backgroundColor: AppCardColors.backgroundCardColor,
        appBar: AppBar(
          backgroundColor: this.widget.word.color,
          title: Text(this.widget.word.en.word),
          actions: _buildActions(),
          bottom: TabBar(
            indicatorWeight: 3,
            tabs: [

              Tab(text: FlutterI18n.translate(context, 'word.tabs.about')),
              Tab(text: FlutterI18n.translate(context, 'word.tabs.examples')),

              if(
                this.widget.word.en.root != null && 
                this.widget.word.es.root != null
              ) Tab(text: FlutterI18n.translate(context, 'word.tabs.conjugation')),

            ]
          ),
        ),

        body: SafeArea(
          child: TabBarView(children: _children),
        ),

        floatingActionButton: FloatingActionButton(
          child: Text('🤔', style: TextStyle(fontSize: 45)),
          onPressed: () => Navigator
            .of(context)
            .push(MaterialPageRoute(
              builder: (context) => HelpScreen(color: this.widget.word.color)
            )),
        ),
      ),
    );
  }
}
