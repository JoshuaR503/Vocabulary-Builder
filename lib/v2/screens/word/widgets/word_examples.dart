
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/styles.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_button.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';

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
      'Examples',
      style: TextStyles.titleStyle
    );

    final Text examples = Text(
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

  Widget _buildGramaticalCategory() {

    final Text title = Text(
      'Gramatical Category',
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
            category: this.word.en.category,
            word: null,
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
            _buildSizedBox(height: 15),
            _buildGramaticalCategory(),
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