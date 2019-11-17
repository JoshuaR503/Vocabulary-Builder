import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/row_item.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';

class WordConjugationCard extends StatelessWidget {

  final Word word;

  WordConjugationCard({
    @required this.word,
  }) : assert(word != null);

  Widget _buildVerbConjugationCard(BuildContext context) {

    final Text title = Text(
      FlutterI18n.translate(context, 'word.conjugation_section.verb_form.title'),
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
            title: FlutterI18n.translate(context, 'word.conjugation_section.verb_form.infinitive'),
            subtitle: '${this.word.targetLanguage.root}',
          ),
          SizedBox(height: 20),
          RowItem(
            title: FlutterI18n.translate(context, 'word.conjugation_section.verb_form.present'),
            subtitle: '${this.word.targetLanguage.present}',
          ),
          SizedBox(height: 20),
          RowItem(
            title: FlutterI18n.translate(context, 'word.conjugation_section.verb_form.past'),
            subtitle: '${this.word.targetLanguage.past}',
          ),
        ],
      ),
    );
  }

  Widget _buildConjugationSingular(BuildContext context) {

    final Text title = Text(
      FlutterI18n.translate(context, 'word.conjugation_section.first_person_singular.title'),
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
            title: this.word.userLang == 'en' ? 'I' : 'Yo',
            subtitle: '${this.word.targetLanguage.firstPerson}',
          ),

          SizedBox(height: 20),
          RowItem(
            title: this.word.userLang == 'en' ? 'You' : 'Tú',
            subtitle: '${this.word.targetLanguage.secondPerson}',
          ),

          SizedBox(height: 20),
          RowItem(
            title: this.word.userLang == 'en' ? 'She/He/It' : 'Ella/Él/Eso',
            subtitle: '${this.word.targetLanguage.thirdPerson}',
          ),
        ],
      ),
    );
  }

  Widget _buildConjugationCardPlural(BuildContext context) {

    final Text title = Text(
      FlutterI18n.translate(context, 'word.conjugation_section.first_person_plural.title'),
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
            title: this.word.userLang == 'en' ? 'We' : 'Nosotros/as',
            subtitle: '${this.word.targetLanguage.firstPersonPlural}',
          ),

          SizedBox(height: 20),
          RowItem(
            title: this.word.userLang == 'en' ? 'You' : 'Ustedes',
            subtitle: '${this.word.targetLanguage.secondPersonPlural}',
          ),

          SizedBox(height: 20),
          RowItem(
            title: this.word.userLang == 'en' ? 'They' : 'Ellos/as',
            subtitle: '${this.word.targetLanguage.thirdPersonPlural}',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final bool hasVerbForms = this.word.targetLanguage.root != null && this.word.targetLanguage.root.length > 1;
    final bool hasPersonSingular = this.word.targetLanguage.firstPerson != null && this.word.targetLanguage.firstPerson.length > 1;
    final bool hasPersonPlural = this.word.targetLanguage.firstPersonPlural != null && this.word.targetLanguage.firstPersonPlural.length > 1;

    return SimpleContainer(
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              if (hasVerbForms) SizedBox(height: 15),
              if (hasVerbForms) _buildVerbConjugationCard(context),

              if (hasPersonSingular) SizedBox(height: 15),
              if (hasPersonSingular) _buildConjugationSingular(context),

              if (hasPersonPlural) SizedBox(height: 15),
              if (hasPersonPlural) _buildConjugationCardPlural(context),

              SizedBox(height: 80),
            ],
          ),
        ],
      )
    );
  } 
}

