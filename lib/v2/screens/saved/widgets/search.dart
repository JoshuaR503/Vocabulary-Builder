import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/word.dart';

searchWords({BuildContext context, List<Word> list}) {
  return MaterialPageRoute<Word>(
    builder: (context) => Material(
      child: MaterialSearch<Word>(
        barBackgroundColor: Theme.of(context).primaryColor,
        iconColor: Colors.white,
        placeholder: 'Search',
        
        limit: list.length,
        results: list
          .map((Word word) => MaterialSearchResult<Word>(
            icon: Icons.search,
            value: word,
            text: word.targetLanguage.word,
          ))
          .toList(),

        filter: (dynamic value, String criteria) => value.firstLanguage.word
          .toLowerCase()
          .trim()
          .contains(RegExp(r'' + criteria.toLowerCase().trim() + '')),

        onSelect: (dynamic word) {
          return Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => WordScreen(word: word)),
          );
        }
      ),
    ),
  );
}