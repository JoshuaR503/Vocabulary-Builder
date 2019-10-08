
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

class WordAboutCard extends StatelessWidget {

  final Word word;

  WordAboutCard({
    this.word
  }) : assert(word != null);

  Widget _buildSizedBox({double height = 30.0}) {
    return SizedBox(height: height);
  }

  Widget _buildFirstCard() {

    final Text title = Text(
      'Word - ${this.word.en.word}',
      style: TextStyle(
       fontSize: 28,
       fontWeight: FontWeight.bold
      ),
    );

    final Text definition = Text(
      '${this.word.en.definition}',
      style: TextStyle(
       fontSize: 18,
       fontWeight: FontWeight.w400
      ),
    );

    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            _buildSizedBox(height: 15),
            definition,
          ],
        ),
      ),
    );
  }

  Widget _buildSecondCard() {

    final Text title = Text(
      'Translation - ${this.word.es.word}',
      style: TextStyle(
       fontSize: 28,
       fontWeight: FontWeight.bold
      ),
    );

    final Text definition = Text(
      '${this.word.es.definition}',
      style: TextStyle(
       fontSize: 18,
       fontWeight: FontWeight.w400
      ),
    );

    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            _buildSizedBox(height: 15),
            definition,
          ],
        )
      )
    );
  }

  Widget _buildThirdCard() {

    final Text title = Text(
      'Gramatical Category',
      style: TextStyle(
       fontSize: 28,
       fontWeight: FontWeight.bold
      ),
    );

    final Text definition = Text(
      '${this.word.en.category.toUpperCase()}',
      style: TextStyle(
       fontSize: 18,
       fontWeight: FontWeight.w400
      ),
    );

    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            _buildSizedBox(height: 15),
            definition,
          ],
        )
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
            _buildFirstCard(),
            _buildSizedBox(height: 15),
            _buildSecondCard(),
            _buildSizedBox(height: 15),
            _buildThirdCard(),
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