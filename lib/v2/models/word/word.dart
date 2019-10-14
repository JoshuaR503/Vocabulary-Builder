import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/word/metadata.dart';

class Word {
  int dbId;

  final Color color;
  final Color accentColor;
  final String level;
  final String id;
  final WordData en;
  final WordData es;

  Word({
    this.accentColor,
    this.color,
    this.level,
    
    this.en,
    this.es,

    this.id,
    this.dbId,
  });

  static List<Word> converToList(List<dynamic> response) {
    final List<Word> words = [];

    response.forEach((data) {
      final dynamic json = data['EN'];
      final String category = json['category'];
      final Word word = Word(
        accentColor: _accentColor(category),
        color: _color(category),
        id: json['_id'],
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
      case 'phrasal verb':
        return AppColors.orange;
      case 'idiom':
        return AppColors.indigo;
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
      accentColor: AppColors.brown,
      color: AppColors.brown,

      level: map['level'],

      en: WordData.fromMap(map['en']),
      es: WordData.fromMap(map['es']),

      id: map['id'],
      dbId: map['dbId'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic> {
    'accentColor': null,
    'color': null,

    'level': level,
  
    'en': en.toJson(),
    'es': en.toJson(),
    
    'id': id,
    'dbId': dbId,
  };
}