import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/widgets/components/empty.dart';

import 'package:vocabulary_builder/v2/widgets/components/grid.dart';
import 'package:vocabulary_builder/v2/widgets/components/message.dart';
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
          return _buildErrorMessage('Section under construction. Come back later.');
        }

        if (state is WordsNoConnection) {
          return EmptyStateScreen(
            message: "No Connection",
            pathImage: 'assets/pictures/warning.png',
            fixMessage: '\nSlow or not internet connection\nPlease check your connection'
          );
        }

        if (state is WordsError) {
          return EmptyStateScreen(
            message: 'Something unexpected\nwent wrong',
            pathImage: 'assets/pictures/settings.png',
            fixMessage: '\nWe are working to fix this issue\nPlease try again later\n'
          );
        }

        return _buildErrorMessage('Something Unexpected Happened. Did not work.');
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
            message: 'Reload Content',
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
