
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';
import 'package:vocabulary_builder/v2/widgets/components/word_card.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 40.0),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    );
  }

  // TODO: CLEAN CODEEE!!!
  Widget _createWordsCard(List<Word> words) {

    final Size size = MediaQuery.of(context).size;
    final double width = size.width;

    final bool isSmall = width <= 479;
    final int crossAxisCount = isSmall ? 1 : 2;

    final double childAspectRatio = isSmall 
    ? width / 180
    : width / 360;
    
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      itemCount: words.length,
      itemBuilder: (context, index) {

        final Word word = words[index];
        return WordCard(
          word: word,
          index: index,
          onPress: () {},
        );
      }
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