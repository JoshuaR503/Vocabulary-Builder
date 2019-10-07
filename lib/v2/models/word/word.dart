import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/word/metadata.dart';

class Word extends Equatable {
  final Color color;
  final String word;
  final String wordTranslation;

  final String wordPronuntiation;
  final String wordPronuntiationTranslation;

  final String level;

  final WordData en;
  final WordData es;

  Word({
    this.color,
    this.word,
    this.wordTranslation,
    this.wordPronuntiation,
    this.wordPronuntiationTranslation,
    this.level,
    this.en,
    this.es
  }) : super([
    word,
    wordTranslation,
    wordPronuntiation,
    wordPronuntiationTranslation,
    level, en, es
  ]);

  static List<Word> converToList(List<dynamic> response) {
    final List<Word> words = [];

    response.forEach((data) {
      final dynamic json = data['EN'];
      final String category = json['category'];
      final Word word = Word(
        color: _color(category),
        word: data['word'],
        wordTranslation: data['wordTranslation'],
        wordPronuntiation: data['wordPronuntiation'],
        wordPronuntiationTranslation: data['wordPronuntiationTranslation'],
        en: WordData.fromJson(data['EN']),
        es: WordData.fromJson(data['ES']),
        level: data['level']
      );

      words.add(word);
    });

    return words;
  }

  static Color _color(String category) {
    switch (category) {
      case 'noun':
        return AppColors.amber;
      case 'verb':
        return AppColors.red;
      case 'adjective':
        return AppColors.blue;
      case 'phasal verb':
        return AppColors.orange;
      case 'idiom':
        return AppColors.indigo;
      default:
        return AppColors.purple;
    }
  }

}