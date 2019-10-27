import 'package:flutter/material.dart';

class Translation {
  
  Translation({
    @required this.firstLanguage,
    @required this.firstLanguageCode,

    @required this.secondLanguage,
    @required this.secondLanguageCode,
  });

  final String firstLanguage;
  final String firstLanguageCode;

  final String secondLanguage;
  final String secondLanguageCode;
  
  int id;

  static Translation fromMap(Map<String, dynamic> map) {
    return Translation(
      firstLanguage: map['firstLanguage'],
      firstLanguageCode: map['firstLanguageCode'],

      secondLanguage: map['secondLanguage'],
      secondLanguageCode: map['secondLanguageCode'],
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic> {
    'firstLanguage': firstLanguage,
    'firstLanguageCode': firstLanguageCode,  

    'secondLanguage': secondLanguage,
    'secondLanguageCode': secondLanguageCode,
  };
}
