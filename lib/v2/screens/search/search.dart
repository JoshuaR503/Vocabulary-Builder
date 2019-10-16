
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/search/bloc.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/word/word.dart';
import 'package:vocabulary_builder/v2/widgets/components/grid.dart';
import 'package:vocabulary_builder/v2/widgets/components/message.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';

class SearchScreen extends StatefulWidget {

  SearchScreen({
    @required this.search
  }) : assert(search != null);

  final String search;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

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

  BlocBuilder<SearchBloc, SearchState> _buildExpanded() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {

        if (state is LoadingSearchState) {
          return VocabularyBuilderSpinner(color: AppColors.amber);
        }

        if (state is LoadedSearchState) {
          final List<Word> words = state.words;

          return _createWordsCard(words);
        }

        if (state is EmptySearchState) {
          return _buildErrorMessage('Section under construction. Come back later.');
        }

        if (state is ErrorSearchState) {
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
        backgroundColor: Color(0xFF2b2b2b),
        title: Text('Search Screen'),
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