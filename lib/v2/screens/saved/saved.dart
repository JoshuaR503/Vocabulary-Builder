
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/widgets/components/spinner.dart';

class SavedWordsScreen extends StatefulWidget {
  @override
  _SavedWordsScreenState createState() => _SavedWordsScreenState();
}

class _SavedWordsScreenState extends State<SavedWordsScreen> {
  

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

  BlocBuilder<WordBloc, WordState> _buildExpanded() {
    return BlocBuilder<WordBloc, WordState>(
      builder: (BuildContext context, WordState state) {

        if (state is LoadingWordState) {
          return VocabularyBuilderSpinner(color: AppColors.brown);
        } 

        if (state is EmptyWordState) {
          return _buildErrorMessage('Nothing to see here');
        }

        return _buildErrorMessage('Something Unexpected Happened.');
      }
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.brown,
        title: Text('Favorite Words Screen'),
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