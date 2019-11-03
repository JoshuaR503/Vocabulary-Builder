import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
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
  void _handler() {
    BlocProvider
      .of<WordBloc>(context)
      .add(InsertWordEvent(word: this.widget.word));
  }

  void _changeScreen() {
    Navigator
      .of(context)
      .pushNamed('/saved');
  }

  void _builder(context) {
    
    final Text content = Text(
      FlutterI18n.translate(context, 'word.snackbar.text'),
      style: TextStyle(
        color: Colors.white
      ),
    );

    final SnackBar snackbar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: AppColors.snackBar,
      content: content,
      action: SnackBarAction(
        label: FlutterI18n.translate(context, 'word.snackbar.action'),
        textColor: Colors.amber,
        onPressed: _changeScreen,
      ),
    );

    Scaffold
    .of(context)
    .showSnackBar(snackbar);
    _handler();
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
              if (!widget.word.isSaved) _builder(context);
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
            indicatorWeight: 5,
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
          child: Text('🤔', style: TextStyle(fontSize: 35)),
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
