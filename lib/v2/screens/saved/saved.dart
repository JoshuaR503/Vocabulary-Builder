
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/widgets/components/grid.dart';
import 'package:vocabulary_builder/v2/widgets/components/message.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';

class SavedWordsScreen extends StatefulWidget {
  @override
  _SavedWordsScreenState createState() => _SavedWordsScreenState();
}

class _SavedWordsScreenState extends State<SavedWordsScreen> {

  void _deleteHandler() {
    BlocProvider
      .of<WordBloc>(context)
      .dispatch(DeleteWordsEvent());
  }

  
  Widget _buildErrorMessage(String message) {
    return VocabularyBuilderMessage(message: message);
  }

  Widget _createWordsCard(List<Word> words) {

    final Icon topIcon = Icon(Icons.volume_up,  color: Colors.white);
    final Icon bottomIcon = Icon(Icons.forward,  color: Colors.white);
    final String methodName = 'delete';

    return VocabularyBuilderGrid(
      words: words,
      methodName: methodName,
      topIcon: topIcon,
      bottomIcon: bottomIcon,
    );
  }

  BlocBuilder<WordBloc, WordState> _buildExpanded() {
    return BlocBuilder<WordBloc, WordState>(
      builder: (BuildContext context, WordState state) {

        if (state is LoadingWordState) {
          return VocabularyBuilderSpinner(color: AppColors.brown);
        }

        if (state is LoadedWordState) {
          return _createWordsCard(state.words);
        }

        if (state is EmptyWordState) {
          return _buildErrorMessage('Nothing to see here');
        }

        if (state is DeleteWordsEvent) {
          return _buildErrorMessage('Deleting words...');
        }

        return _buildErrorMessage('Something Unexpected Happened.');
      }
    );
  }

  List<Widget> _buildAppbarActions()  {
    return [
      Tooltip(
        message: 'Erease everything',
        child: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteHandler,
          )
        )
      ),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.brown,
        title: Text('Favorite Words Screen'),
        actions: _buildAppbarActions(),
        centerTitle: true,
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
