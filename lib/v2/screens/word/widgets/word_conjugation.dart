import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/row_item.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';

class WordConjugationCard extends StatelessWidget {

  final Word word;

  WordConjugationCard({
    this.word
  }) : assert(word != null);

  Widget _buildVerbConjugationCard() {

    final Text title = Text(
      'Verb Forms',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      )
    );

    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          SizedBox(height: 25),
          RowItem(
            title: 'Infinitive',
            subtitle: '${this.word.en.root}',
          ),
          SizedBox(height: 20),
          RowItem(
            title: 'Present Participle',
            subtitle: '${this.word.en.present}',
          ),
          SizedBox(height: 20),
          RowItem(
            title: 'Past Participle',
            subtitle: '${this.word.en.past}',
          ),
        ],
      ),
    );
  }

  Widget _buildConjugationSingular() {

    final Text title = Text(
      'First Person Singular',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      )
    );

    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,

          SizedBox(height: 25),
          RowItem(
            title: 'I',
            subtitle: '${this.word.en.firstPerson}',
          ),

          SizedBox(height: 20),
          RowItem(
            title: 'You',
            subtitle: '${this.word.en.secondPerson}',
          ),

          SizedBox(height: 20),
          RowItem(
            title: 'she/he/it',
            subtitle: '${this.word.en.thirdPerson}',
          ),
        ],
      ),
    );
  }

  Widget _buildConjugationCardPlural() {

    final Text title = Text(
      'First Person Plural',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      )
    );

    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,

          SizedBox(height: 20),
          RowItem(
            title: 'We',
            subtitle: '${this.word.en.firstPersonPlural}',
          ),

          SizedBox(height: 20),
          RowItem(
            title: 'You',
            subtitle: '${this.word.en.secondPersonPlural}',
          ),

          SizedBox(height: 20),
          RowItem(
            title: 'They',
            subtitle: '${this.word.en.thirdPersonPlural}',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final bool hasVerbForms = this.word.en.root != null && this.word.en.root.length > 1;
    final bool hasPersonSingular = this.word.en.firstPerson != null && this.word.en.firstPerson.length > 1;
    final bool hasPersonPlural = this.word.en.firstPersonPlural != null && this.word.en.firstPersonPlural.length > 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              if (hasVerbForms) SizedBox(height: 15),
              if (hasVerbForms) _buildVerbConjugationCard(),

              if (hasPersonSingular) SizedBox(height: 15),
              if (hasPersonSingular) _buildConjugationSingular(),

              if (hasPersonPlural) SizedBox(height: 15),
              if (hasPersonPlural) _buildConjugationCardPlural(),

              SizedBox(height: 40),
            ],
          ),
        ],
      )
    );
  } 
}