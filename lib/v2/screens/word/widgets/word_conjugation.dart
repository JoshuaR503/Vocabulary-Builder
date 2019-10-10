
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/styles.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/row_item.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';

class WordConjugationCard extends StatelessWidget {

  final Word word;

  WordConjugationCard({
    this.word
  }) : assert(word != null);

  Widget _buildSizedBox({double height = 30.0}) {
    return SizedBox(height: height);
  }

  Widget _buildConjugationCard() {

    final Text title = Text(
      'Indicative Conjugation',
      style: TextStyles.titleStyle
    );

    return WordDataCard(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            title,
            _buildSizedBox(height: 20),
            RowItem(
              title: 'First Person',
              subtitle: '${this.word.en.firstPerson}',
            ),

            _buildSizedBox(height: 20),
            RowItem(
              title: 'Second Person',
              subtitle: '${this.word.en.secondPerson}',
            ),

            _buildSizedBox(height: 20),
            RowItem(
              title: 'Third Person',
              subtitle: '${this.word.en.thirdPerson}',
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildVerbConjugationCard() {

    final Text title = Text(
      'Verb Conjugation',
      style: TextStyles.titleStyle
    );

    return WordDataCard(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            title,
            _buildSizedBox(height: 20),
            RowItem(
              title: 'Root',
              subtitle: '${this.word.en.root}',
            ),

            _buildSizedBox(height: 20),
            RowItem(
              title: 'Present',
              subtitle: '${this.word.en.present}',
            ),

            _buildSizedBox(height: 20),
            RowItem(
              title: 'Past',
              subtitle: '${this.word.en.past}',
            ),

          ],
        ),
      ),
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
            _buildConjugationCard(),
             _buildSizedBox(height: 15),
            _buildVerbConjugationCard()
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