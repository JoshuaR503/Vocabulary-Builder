

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/translation/bloc.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';

class Translations extends StatefulWidget {
  @override
  _TranslationsState createState() => _TranslationsState();
}

class _TranslationsState extends State<Translations> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (BuildContext context, TranslationState state) {

        if (state is LoaedTranslationSavedState) {
          return ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: state.translations.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white10,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.translate), 
                    foregroundColor: Colors.white, 
                    backgroundColor: AppColors.tealAccent,
                  ),
                  title: Text(
                    state.translations[index].firstLanguage,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis
                  ),
                  subtitle: Text(
                    state.translations[index].secondLanguage,
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              );
            }
          );
        }

        return Container();
      }
    );
  }
}

