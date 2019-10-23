
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_card.dart';
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

  Widget _buildAnimatedContainer({Widget child, Function onTap}) {

    final Widget icon = AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color:  Colors.black.withOpacity(0.5),
      ),
      height: 35.0,
      width: 50,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Icon(Icons.volume_up)
        ),
      ),
    );


    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(right: 15),
          child: child,
        ),

        icon
      ]
    );
  }

  List<Widget> _buildDefinitionSectionEnChildren() {

    final bool hasDefinition = this.word.en.definition != null;
    final String text = hasDefinition ? this.word.en.definition : 'No definition was not provided.';

    final Text title2 = Text(
      '${this.word.en.word}',
      style: TextStyles.titleStyle
    );

    final Text definition1 = Text(
      text,
      style: TextStyles.definitionStyle
    );

    final Widget header2 = _buildAnimatedContainer(
      child: title2,
      onTap: () => functions.playAudio(audio: this.word.en.wordPronuntiation)
    );

    return [
      header2,
      _buildSizedBox(height: 10),
      definition1,
    ];
  }

  Widget _buildDefinitonEnSection() {
    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildDefinitionSectionEnChildren(),
      )
    );
  }

  List<Widget> _buildDefinitionSectionChildren() {

    final bool hasDefinition = this.word.es.definition != null;
    final String text = hasDefinition ? this.word.es.definition : 'No definition was not provided.';

    final Text title2 = Text(
      '${this.word.es.word}',
      overflow: TextOverflow.ellipsis,
      style: TextStyles.titleStyle
    );

    final Text definition2 = Text(
      text,
      style: TextStyles.definitionStyle
    );

    final Widget header2 = _buildAnimatedContainer(
      child: title2,
      onTap: () => functions.playAudio(audio: this.word.es.wordPronuntiation)
    );

    return [
      header2,
      _buildSizedBox(height: 10),
      definition2,
    ];
  }
  
  Widget _buildDefinitonSection() {
    return WordDataCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildDefinitionSectionChildren(),
      )
    );
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
              _buildDefinitonSection(),
              _buildSizedBox(height: 15),
              _buildDefinitonEnSection(),
              _buildSizedBox(height: 15),
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

  @override
  Widget build(BuildContext context) {
    return _buildVerticallLayout();
  } 
}
