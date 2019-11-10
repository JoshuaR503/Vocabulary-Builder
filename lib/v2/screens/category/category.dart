import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/widgets/components/cards/grid.dart';

import 'package:vocabulary_builder/v2/widgets/components/message.dart';
import 'package:vocabulary_builder/v2/widgets/components/solution.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';

class Category extends StatefulWidget {
  
  final String title;
  final String route;
  final String categoryName;

  final Color color;
  final Color accentColor;

  Category({
    @required this.title,
    @required this.route,
    @required this.categoryName,

    @required this.color,
    @required this.accentColor
  }) : assert(title != null),
       assert(color != null),
       assert(accentColor != null);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  // Methods
  void _reloadContent() {
    BlocProvider
      .of<WordsBloc>(context)
      .add(FetchWords(
        category: this.widget.route,
        categoryName: this.widget.categoryName
      ));
  }

  // Helpers
  Widget _buildError(String message, String solution) {
    return SimpleContainer(
      child: ListView(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height / 3.5.toDouble()),
          VocabularyBuilderMessage(message: message),
          VocabularyBuilderSolutionMessage(solution: solution)
        ],
      ),
    );
  }

  Widget _createWordsCard(List<Word> words) {

    final Icon topIcon = Icon(Icons.volume_up,  color: Colors.white);
    final Icon bottomIcon = Icon(Icons.forward,  color: Colors.white);
    final String methodName = 'audio';

    return VocabularyBuilderGrid(
      words: words,
      methodName: methodName,
      topIcon: topIcon,
      bottomIcon: bottomIcon,
    );
  }

  // Actual Widgets
  BlocBuilder<WordsBloc, WordsState> _buildExpanded() {
    return BlocBuilder<WordsBloc, WordsState>(
      builder: (BuildContext context, WordsState state) {

        if (state is SectionNotAvailable) {
          return _buildError(
            FlutterI18n.translate(context, 'category.unavailable.title'),
            FlutterI18n.translate(context, 'category.unavailable.message'),
          );
        }

        if (state is WordsLoading) {
          return VocabularyBuilderSpinner(color: this.widget.color);
        }

        if (state is WordsLoaded) {
          final List<Word> words = state.words;

          return _createWordsCard(words);
        }

        if (state is WordsZero) {
          return _buildError(
            FlutterI18n.translate(context, 'category.empty'),
            FlutterI18n.translate(context, 'category.empty'),
          );
        }

        if (state is WordsNoConnection) {
          return _buildError(
            FlutterI18n.translate(context, 'category.no_connection.title'),
            FlutterI18n.translate(context, 'category.no_connection.message'),
          );
        }

        if (state is WordsError) {
          return _buildError(
            FlutterI18n.translate(context, 'category.error.title'),
            FlutterI18n.translate(context, 'category.error.message'),
          );
        }

        return VocabularyBuilderSpinner(color: this.widget.color);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.widget.accentColor,
        title: Text(this.widget.title),
        actions: <Widget>[
          Tooltip(
            message: FlutterI18n.translate(context, 'category.reload'),
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _reloadContent
            ),
          ),
        ],
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: SafeArea(
          child: _buildExpanded(),
        )
      ),
    );
  }
}
