
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/styles.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_button.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';

class WordAboutCard extends StatelessWidget {

  final Word word;

  WordAboutCard({
    this.word
  }) : assert(word != null);

  Widget _buildSizedBox({double height = 30.0}) {
    return SizedBox(height: height);
  }

  List<Widget> _buildFirstCardChildren() {

    final Text title1 = Text(
      '${this.word.en.word}',
      style: TextStyles.titleStyle
    );

    final Text title2 = Text(
      '${this.word.es.word}',
      style: TextStyles.titleStyle
    );

    final Text definition1 = Text(
      '${this.word.en.definition}',
      style: TextStyles.definitionStyle
    );

    final Text definition2 = Text(
      '${this.word.es.definition}',
      style: TextStyles.definitionStyle
    );

    return [
      title1,
      _buildSizedBox(height: 15),
      definition1,
      _buildSizedBox(),
      title2,
      _buildSizedBox(height: 15),
      definition2,
    ];
  }

  Widget _buildFirstCard() {
    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildFirstCardChildren(),
      )
    );
  }

  Widget _buildThirdCard() {

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildSizedBox(height: 15),
              _buildFirstCard(),
              _buildSizedBox(height: 15),
              _buildThirdCard(),
              _buildSizedBox(height: 90),
            ],
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildVerticallLayout();
  } 
}