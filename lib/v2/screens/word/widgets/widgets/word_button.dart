import 'package:flutter/material.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';

class WordCateogry extends StatelessWidget {

  final Word word;
  final String category;

  WordCateogry({
    this.word,
    this.category,
  }) : assert(category != null);

  void _playAudio(String text) async {

    final VocabularyBuilderFunctions functions = VocabularyBuilderFunctions();

    final String lang = 'en';
    final String word = this.word.targetLanguage.word.trim().replaceAll(RegExp(r"\s+\b|\b\s"), "-");
    final String fileName = text.trim().replaceAll(RegExp(r"\s+\b|\b\s"), "-");
    final String url = 'https://vocabulary-builder-sounds-bucket.s3.amazonaws.com/$lang-$word-$fileName.mp3';

    functions.playAudio(audio: url);
  }

  Widget _buildContainer({String text}) {
    final String cleanText = text.trim();
    final int length = cleanText.length;
    final double width = length < 8 
    ? length * 18.0 
    : length * 14.0;

    return GestureDetector(
      onTap: () { if (this.word != null) _playAudio(cleanText); },
      child: Container(
        width: width,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color:  Colors.black.withOpacity(0.5),
        ),

        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainers({int size, List categories}) {
    return ListView.builder(  
      scrollDirection: Axis.horizontal,
      itemCount: size,
      itemBuilder: (context, index) =>
        Container(
          padding: EdgeInsets.only(right: 15.0),
          child: _buildContainer(text: categories[index])
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final List categories = category.split(',');
    final int categoriesSzie = categories.length;
  
    return Container(
      height: 50.0,
      child: categoriesSzie > 1
      ? _buildContainers(size: categoriesSzie, categories: categories)
      : _buildContainer(text: category),
    );
  }
}