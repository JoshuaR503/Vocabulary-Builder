import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:moblie/model/main.dart';
import 'package:moblie/model/palabra.model.dart';

import 'package:material_search/material_search.dart';
import 'package:moblie/pages/palabra-single-screen.dart';

searchPalabras(BuildContext context, List list, MainModel model) {
  return MaterialPageRoute <Palabra> (
    builder: (context) => Material(

      child: MaterialSearch<Palabra>(
        barBackgroundColor: Theme.of(context).primaryColor,
        iconColor: Colors.white,
        placeholder: FlutterI18n.translate(context, 'search'),

        limit: list.length,
        results: list
          .map((palabra) => MaterialSearchResult<Palabra>(
            icon: Icons.search,
            value: palabra,
            text: palabra.palabra,
          ))
          .toList(),

        filter: (dynamic value, String criteria) => value.palabra
          .toLowerCase()
          .trim()
          .contains(RegExp(r'' + criteria.toLowerCase().trim() + '')),

        onSelect: (dynamic palabra) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SinglePalabraScreen(palabra)
          ),
        )
      ),
    )
  );
}