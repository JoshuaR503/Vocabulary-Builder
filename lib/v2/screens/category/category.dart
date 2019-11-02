import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';

import 'package:vocabulary_builder/v2/models/models.dart';

import 'package:vocabulary_builder/v2/widgets/components/grid.dart';
import 'package:vocabulary_builder/v2/widgets/components/message.dart';
import 'package:vocabulary_builder/v2/widgets/components/solution.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';

class Category extends StatefulWidget {
  
  final String title;
  final String route;
  final Color color;
  final Color accentColor;

  Category({
    @required this.title,
    @required this.route,
    @required this.color,
    @required this.accentColor
  }) : assert(title != null),
       assert(color != null),
       assert(accentColor != null);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  @override
  void dispose() {
    super.dispose();
  }

  void _reloadContent() {
    BlocProvider
      .of<WordsBloc>(context)
      .add(FetchWords(category: this.widget.route));
  }

  // Helpers
  Widget _buildError(String message, String solution) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        VocabularyBuilderMessage(message: message),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text('🙁', style: TextStyle(fontSize: 55)),
        ),
        VocabularyBuilderSolutionMessage(solution: solution)
      ],
    );
  }

  Widget _buildErrorMessage(String message) {
    return VocabularyBuilderMessage(message: message);
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

        return _buildErrorMessage(  FlutterI18n.translate(context, 'category.empty'));
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
