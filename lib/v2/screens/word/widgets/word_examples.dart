import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

import 'package:vocabulary_builder/v2/screens/word/widgets/widgets/word_button.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';

class WordExamplesCard extends StatelessWidget {

  final Word word;

  WordExamplesCard({
    @required this.word,
  }) : assert(word != null);

  // Helpers
  Widget _buildCard({Widget child}) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Material(
        color: Color(0XFF2b2b2b),
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: child,
      ),
    );
  }

  Widget _buildWordsCard({Widget title, Widget data}) {

    final List<Widget> children = <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 30, left: 30, top: 25, bottom: 10),
        child: title
      ),

      Padding(
        padding: EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 25),
        child: data
      )
    ];

    return _buildSection(children: children);
  }

  Widget _buildSection({List<Widget> children}) {

    final Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
    );

    return _buildCard(child: child);
  }

  // Actual Widgets
  Widget _builGif(BuildContext context) {

    final Widget errorWidget = Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: Icon(Icons.warning),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Text(
              FlutterI18n.translate(context, 'word.examples_section.gif.notLoading'), 
              style: TextStyles.definitionStyle
            )
          ),
        ],
      )
    );

    final Widget placeholder = Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: VocabularyBuilderSpinner(color: this.word.color),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Text(
              FlutterI18n.translate(context, 'word.examples_section.gif.loading'), 
              style: TextStyles.definitionStyle
            )
          ),
        ],
      )
    );

    final List<Widget> children = <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: this.word.gif,
            placeholder: (context, url) => placeholder,
            errorWidget: (context, url, error) => errorWidget
          ),
        ),
      ),
    ];

    return _buildSection(children: children);
  }

  Widget _buildExamplesCard(BuildContext context) {

    final Text title = Text(
      FlutterI18n.translate(context, 'word.examples_section.sentences'),
      style: TextStyles.titleStyle
    );

    final SelectableText data = SelectableText(
      '${this.word.targetLanguage.examples}'.trim(),
      style: TextStyles.definitionStyle,
      cursorColor: this.word.color,
    );

    return _buildWordsCard(title: title, data: data);
  }

  Widget _buildSynonymsCard(BuildContext context) {

    final Text title = Text(
      FlutterI18n.translate(context, 'word.examples_section.similar_words'),
      style: TextStyles.titleStyle
    );

    final Widget data = WordCateogry(
      category: this.word.targetLanguage.synonyms,
      word: this.word,
    );

    return _buildWordsCard(title: title, data: data);
  }

  Widget _buildAntonymsCard(BuildContext context) {

    final Text title = Text(
      FlutterI18n.translate(context, 'word.examples_section.oposite_words'),
      style: TextStyles.titleStyle
    );

    final Widget data = WordCateogry(
      category: this.word.targetLanguage.antonyms,
      word: this.word,
    );

    return _buildWordsCard(title: title, data: data);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              if (word.gif != null && word.gif.length > 1) SizedBox(height: 5),
              if (word.gif != null && word.gif.length > 1) _builGif(context),

              if (word.gif == null || word.gif.length < 1) SizedBox(height: 10),
              _buildExamplesCard(context),

              if (
                word.targetLanguage.synonyms != null && 
                word.targetLanguage.synonyms.length > 1
              ) SizedBox(height: 5),

              if (
                word.targetLanguage.synonyms != null && 
                word.targetLanguage.synonyms.length > 1
              ) _buildSynonymsCard(context),

              if (
                word.targetLanguage.antonyms != null && 
                word.targetLanguage.antonyms.length > 1
              ) SizedBox(height: 5),

              if (
                word.targetLanguage.antonyms != null && 
                word.targetLanguage.antonyms.length > 1
              ) _buildAntonymsCard(context),

              SizedBox(height: 40),
            ],
          ),
        ],
      )
    );
  } 
}
