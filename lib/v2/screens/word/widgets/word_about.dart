import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_data_card.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';

class WordAboutCard extends StatelessWidget {

  final Word word;
  final VocabularyBuilderFunctions functions = VocabularyBuilderFunctions();

  WordAboutCard({
    this.word
  }) : assert(word != null);

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

  // Actuall Widgets.
  Widget _buildFirstCard(BuildContext context) {
    return WordCard(
      word: this.word.en.word,
      definition: this.word.en.definition,
    );
  }

  Widget _buildSecondCard(BuildContext context) {
    return WordCard(
      word: this.word.es.word,
      definition: this.word.es.definition,
    );
  }

  Widget _buildCategorySection() {

    final Text title = Text(
      'Gramatical Category',
      style: TextStyles.titleStyle
    );

    final Text definition = Text(
      this.word.en.category,
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

  Widget _buildNoteSection() {

    final Text title = Text(
      'Something you must know',
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

  Widget _builGif() {

    final List<Widget> children = <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Image.network('https://media.giphy.com/media/ycpCka5zPAUvMr6PU6/giphy.gif'),
      ),
      
      Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
        child: Text(
          'Provided by Giphy', 
          style: TextStyles.titleStyle
        ),
      )
    ];

    return _buildSection(children: children);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
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

              SizedBox(height: 5),
              _buildCategorySection(),

              if (word.gift != null) SizedBox(height: 5),
              if (word.gift != null) _builGif(),

              SizedBox(height: 10),
              if (word.en.note != null) _buildNoteSection(),
              if (word.en.note != null) SizedBox(height: 15),

              SizedBox(height: 40),
            ],
          ),
        ],
      )
    );
  }
}