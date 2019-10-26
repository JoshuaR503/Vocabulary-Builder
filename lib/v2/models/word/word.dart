import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/word/metadata.dart';

class Word {

  final Color color;
  final Color accentColor;
  final String level;
  
  final WordData en;
  final WordData es;

  final String gif;
  
  bool isSaved = false;
  int id;

  Word({
    this.accentColor,
    this.color,
    this.level,
    
    this.en,
    this.es,

    this.gif,
  });

  static List<Word> converToList(List<dynamic> response) {
    final List<Word> words = [];

    response.forEach((data) {
      
      final WordData json = WordData.fromJson(data['EN']);
      final Word word = Word(
        accentColor: _accentColor(json.category),
        color: _color(json.category),
        
        en: WordData.fromJson(data['EN']),
        es: WordData.fromJson(data['ES']),

        gif: data['gif'],
        level: data['level']
      );

      words.add(word);
    });

    return words;
  }

  static Color _color(String category) {
    switch (category) {
      case 'noun':
        return AppColors.amberAccent;
      case 'verb':
        return AppColors.red;
      case 'adjective':
        return AppColors.blue;
      case 'phrasal verb':
        return AppColors.orange;
      case 'idiom':
        return AppColors.brown;
      default:
        return AppColors.purple;
    }
  }

  static Color _accentColor(String category) {
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

  static Word fromMap(Map<String, dynamic> map) {
    return Word(
      accentColor: AppColors.indigo,
      color: AppColors.indigo,

      level: map['level'],

      en: WordData.fromMap(map['en']),
      es: WordData.fromMap(map['es']),

      gif: map['gif'],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic> {
    'accentColor': null,
    'color': null,

    'level': level,
  
    'en': en.toMap(),
    'es': es.toMap(),
    
    'gif': gif,
  };
}