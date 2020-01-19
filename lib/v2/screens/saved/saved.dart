
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/saved/widgets/search.dart';
import 'package:vocabulary_builder/v2/widgets/components/cards/grid.dart';
import 'package:vocabulary_builder/v2/widgets/components/empty.dart';

import 'package:vocabulary_builder/v2/widgets/components/message.dart';
import 'package:vocabulary_builder/v2/widgets/components/solution.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';

class SavedWordsScreen extends StatefulWidget {
  @override
  _SavedWordsScreenState createState() => _SavedWordsScreenState();
}

class _SavedWordsScreenState extends State<SavedWordsScreen> {

  // Helpers
  Widget _buildError(String message, String solution) {
    return SimpleContainer(
      child: ListView(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height / 3.8.toDouble()),
          VocabularyBuilderMessage(message: message),
          VocabularyBuilderSolutionMessage(solution: solution)
        ],
      ),
    );
  }
  
  Widget _createWordsCard(List<Word> words) {

    final Icon bottomIcon = Icon(Icons.forward,  color: Colors.white);
    final Icon topIcon = Icon(Icons.delete);
    final String methodName = 'delete';

    return VocabularyBuilderGrid(
      words: words,
      methodName: methodName,
      topIcon: topIcon,
      bottomIcon: bottomIcon,
    );
  }

  // Actual Widgets
  BlocBuilder<WordBloc, WordState> _buildExpanded() {
    return BlocBuilder<WordBloc, WordState>(
      builder: (BuildContext context, WordState state) {

        if (state is LoadingWordState) {
          return VocabularyBuilderSpinner(color: AppColors.brown);
        }

        if (state is LoadedWordState) {
          return _createWordsCard(state.words);
        }

        if (state is ErrorWordState) {
          return _buildError(
            FlutterI18n.translate(context, 'saved.error.title'),
            FlutterI18n.translate(context, 'saved.error.message'),
          );
        }

        if (state is EmptyWordState) {

          return EmptyStateScreen(
            message: FlutterI18n.translate(context, 'saved.title'),
            fixMessage: FlutterI18n.translate(context, 'saved.message'),
            pathImage: 'assets/pictures/banner.png',
          );
        }

        return VocabularyBuilderSpinner(color: AppColors.indigo);
      }
    );
  }

  BlocBuilder<WordBloc, WordState> _buildSearchIcon() {
    return BlocBuilder<WordBloc, WordState>(
      builder: (BuildContext context, WordState state) {

        if (state is LoadedWordState) {
          return IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator
              .of(context)
              .push(searchWords(
                context: context, 
                list: state.words
              )),
          );
        }

        return IconButton(
          icon: Icon(Icons.search),
          onPressed: null
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.indigo,
        title: Text(FlutterI18n.translate(context, 'saved.section_title')),
        actions: <Widget>[
          Tooltip(
            message: 'Search',
            child: _buildSearchIcon()
          ),
        ]
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: SafeArea(
          child: _buildExpanded()
        )
      ),
    );
  }
}
