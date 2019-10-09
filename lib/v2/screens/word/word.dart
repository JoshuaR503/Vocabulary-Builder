import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/word_about.dart';
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Tooltip(
                message: 'Reload Content',
                child: IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {}
                ),
              ),
            ],
            backgroundColor: this.widget.word.color,
            bottom: TabBar(
              indicatorWeight: 3,
              tabs: [
                Tab(text: 'About',),
                Tab(text: 'Examples',),
                // Tab(text: 'Conjugation'),
              ],
            ),
            title: Text(this.widget.word.en.word),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                WordAboutCard(word: this.widget.word),
                WordExamplesCard(word: this.widget.word),
                // WordConjugationCard(word: this.widget.word),
              ],
            ),
          )
        )
    );
  }
}