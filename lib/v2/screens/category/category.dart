
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/widgets/components/grid.dart';
import 'package:vocabulary_builder/v2/widgets/components/message.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';

class Category extends StatefulWidget {
  
  final String title;
  final Color color;

  Category({
    @required this.title,
    @required this.color
  }) : assert(title != null),
       assert(color != null);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

        if (state is WordsError) {
          return _buildErrorMessage(state.error.toString());
        }

        return _buildErrorMessage('Something Unexpected Happened. Did not work.');
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.widget.color,
        title: Text(this.widget.title),
        actions: <Widget>[
          Tooltip(
            message: 'Reload Content',
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {}
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
