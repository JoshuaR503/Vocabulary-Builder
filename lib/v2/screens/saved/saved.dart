
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/saved/widgets/search.dart';
import 'package:vocabulary_builder/v2/widgets/components/empty.dart';
import 'package:vocabulary_builder/v2/widgets/components/grid.dart';
import 'package:vocabulary_builder/v2/widgets/components/message.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';

class SavedWordsScreen extends StatefulWidget {
  @override
  _SavedWordsScreenState createState() => _SavedWordsScreenState();
}

class _SavedWordsScreenState extends State<SavedWordsScreen> {

  // void _deleteHandler() {
  //   BlocProvider
  //     .of<WordBloc>(context)
  //     .dispatch(DeleteWordsEvent());
  // }

  Widget _buildErrorMessage(String message) {
    return VocabularyBuilderMessage(message: message);
  }

  Widget _createWordsCard(List<Word> words) {

    final Icon bottomIcon = Icon(Icons.forward,  color: Colors.white);
    final Icon topIcon = Icon(FontAwesomeIcons.trashAlt);
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
          return EmptyStateScreen(
            message: FlutterI18n.translate(context, 'screens.saved.message'),
            pathImage: 'assets/pictures/box.png',
            fixMessage: FlutterI18n.translate(context, 'screens.saved.solution')
          );
        }

        if (state is DeleteWordsEvent) {
          return _buildErrorMessage('Deleting words...');
        }

        return _buildErrorMessage('Something Unexpected Happened.');
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

  List<Widget> _buildAppbarActions(){
    return [
      Tooltip(
        message: 'Search',
        child: _buildSearchIcon()
      ),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.brown,
        title: Text('Saved'),
        actions: _buildAppbarActions(),
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
