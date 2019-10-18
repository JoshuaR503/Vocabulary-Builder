import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';
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
  final List<Tab> _tabs = [
    Tab(text: 'About'),
    Tab(text: 'Examples')
  ];

  @override
  void initState() {
    _children.add(WordAboutCard(word: this.widget.word));
    _children.add(WordExamplesCard(word: this.widget.word));

    if (
      this.widget.word.en.root != null && 
      this.widget.word.es.root != null
    ) {
      _tabs.add(Tab(text: 'Conjugation'));
      _children.add(WordConjugationCard(word: this.widget.word));
    }

    super.initState();
  }

  void _handler() {
    BlocProvider
      .of<WordBloc>(context)
      .dispatch(InsertWordEvent(word: this.widget.word));
  }

  void _changeScreen() {
    Navigator
      .of(context)
      .pushNamed('/saved');
  }

  void _builder(context) {
    
    final Text content = Text(
      'Word Saved',
      style: TextStyle(
        color: Colors.white
      ),
    );

    final SnackBar snackbar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Color(0XFF383838),
      content: content,
      action: SnackBarAction(
        label: 'Show Me',
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
        message: 'Add to favorites',
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
  
  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: this.widget.word.color,
      title: Text(this.widget.word.en.word),
      actions: _buildActions(),
      bottom: TabBar(
        indicatorWeight: 3,
        tabs: _tabs
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Color(0xFF1e1e1e),
        appBar: _buildAppBar(),
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
