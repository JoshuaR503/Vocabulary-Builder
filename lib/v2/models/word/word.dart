import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/word/metadata.dart';

class Word {

  final Color color;
  final Color accentColor;
  final String level;
  
  final WordData firstLanguage;
  final WordData targetLanguage;

  final String gif;
  
  bool isSaved = false;
  int id;

  Word({
    this.accentColor,
    this.color,
    this.level,
    
    this.firstLanguage,
    this.targetLanguage,

    this.gif,
  });

  static List<Word> converToList(List<dynamic> response, Map<String, String> langMedaData) {
    final List<Word> words = [];

    response.forEach((data) {

      final WordData json = WordData.fromJson(data['EN']);
      final Word word = Word(
        accentColor: _accentColor(json.category),
        color: _color(json.category),
        
        firstLanguage: WordData.fromJson(data[langMedaData['firstLanguage']]),
        targetLanguage: WordData.fromJson(data[langMedaData['targetLanguage']]),

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
      case 'adverb':
        return AppColors.tealAccent;
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

  static Word fromMap(Map<String, dynamic> map, Map<String, String> langMedaData) {
    return Word(
      accentColor: AppColors.indigo,
      color: AppColors.indigo,

      level: map['level'],

      firstLanguage: WordData.fromJson(map[langMedaData['firstLanguage']]),
      targetLanguage: WordData.fromJson(map[langMedaData['targetLanguage']]),

      gif: map['gif'],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic> {
    'accentColor': null,
    'color': null,

    'level': level,
  
    'firstLanguage': firstLanguage.toMap(),
    'targetLanguage': targetLanguage.toMap(),
    
    'gif': gif,
  };
}

