

import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String word;
  final String wordTranslation;

  final String wordPronuntiation;
  final String wordPronuntiationTranslation;

  final String level;

  final Object en;
  final Object es;

  Word({
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
    level,
    en,
    es
  ]);

  static List<Word> converToList(List<dynamic> response) {
    final List<Word> words = [];

    response.forEach((data) {
      final Word word = Word(
        word: data['word'],
        wordTranslation: data['wordTranslation'],
        wordPronuntiation: data['wordPronuntiation'],
        wordPronuntiationTranslation: data['wordPronuntiationTranslation'],
        level: data['level']
      );

      print('${word.word}');

      words.add(word);
    });

    return words;
  }
}