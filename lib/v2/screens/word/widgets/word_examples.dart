import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_button.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';

class WordExamplesCard extends StatelessWidget {

  final Word word;

  WordExamplesCard({
    this.word
  }) : assert(word != null);

  Widget _buildSizedBox({double height = 30.0}) {
    return SizedBox(height: height);
  }

  Widget _buildExamplesCard() {

    final Text title = Text(
      'Sentences',
      style: TextStyles.titleStyle
    );

    final SelectableText examples = SelectableText(
      '${this.word.en.examples}',
      style: TextStyles.definitionStyle
    );

    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          _buildSizedBox(height: 20),
          examples,
        ],
      ),
    );
  }

  Widget _buildSynonymsCard() {

    final Text title = Text(
      'Synonyms',
      style: TextStyles.titleStyle
    );

    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          _buildSizedBox(height: 15),
          WordCateogry(
            category: this.word.en.synonyms,
            word: this.word,
          ),
        ],
      )
    );
  }

  Widget _buildAntonymsCard() {

    final Text title2 = Text(
      'Antonyms',
      style: TextStyles.titleStyle
    );

    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title2,
          _buildSizedBox(height: 15),
          WordCateogry(
            category: this.word.en.antonyms,
            word: this.word,
          ),
        ],
      )
    );
  }

  Widget _buildVerticallLayout() {
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSizedBox(height: 15),
            _buildExamplesCard(),
            if (word.en.synonyms != null) _buildSizedBox(height: 15),
            if (word.en.synonyms != null) _buildSynonymsCard(),
            if (word.en.antonyms != null) _buildSizedBox(height: 15),
            if (word.en.antonyms != null) _buildAntonymsCard(),
            _buildSizedBox(height: 90),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: _buildVerticallLayout()
    );
  } 
}

