import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_data_card.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';

class WordAboutCard extends StatelessWidget {

  final Word word;
  final VocabularyBuilderFunctions functions = VocabularyBuilderFunctions();

  WordAboutCard({
    this.word
  }) : assert(word != null);

  Widget _buildSizedBox({double height = 30.0}) {
    return SizedBox(height: height);
  }

  Widget _buildGramaticalCategory() {

    final Text title = Text(
      'Gramatical Category',
      style: TextStyles.titleStyle
    );

    final Text definition = Text(
      this.word.en.category,
      style: TextStyles.definitionStyle,
    );

    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          _buildSizedBox(height: 15),
          definition
        ],
      )
    );
  }

  Widget _buildSection() {

    final Text title = Text(
      'Something you must know',
      style: TextStyles.titleStyle
    );

    final Text definition = Text(
      this.word.en.note,
      style: TextStyles.definitionStyle,
    );

    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          _buildSizedBox(height: 15),
          definition
        ],
      )
    );
  }

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
              
              _buildSizedBox(height: 15),
              _buildFirstCard(context),

              _buildSizedBox(height: 5),
              _buildSecondCard(context),

              _buildSizedBox(height: 10),
              if (word.en.note != null) _buildSection(),
              if (word.en.note != null) _buildSizedBox(height: 15),

              _buildGramaticalCategory(),
              _buildSizedBox(height: 60),
            ],
          ),
        ],
      )
    );
  }

}
