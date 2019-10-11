import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/word_about.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/word_conjugation.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/word_examples.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    if (this.widget.word.en.root != null) {
      _tabs.add(Tab(text: 'Conjugation'));
      _children.add(WordConjugationCard(word: this.widget.word));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Color(0xFF1e1e1e),
        appBar: AppBar(
          actions: <Widget>[
            Tooltip(
              message: 'Add to favorites',
              child: IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {}
              ),
            ),
          ],
          backgroundColor: this.widget.word.color,
          bottom: TabBar(
            indicatorWeight: 3,
            tabs: _tabs
          ),
          title: Text(this.widget.word.en.word),
        ),
        body: SafeArea(
          child: TabBarView(
            children: _children,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(FontAwesomeIcons.question),
          onPressed: () {}
        ),
      )
    );
  }
}