import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/routes/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';
import 'package:vocabulary_builder/v2/screens/category/widgets/word_card.dart';
import 'package:vocabulary_builder/v2/widgets/components/container.dart';

class Category extends StatefulWidget {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 40.0),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  BlocBuilder<WordsBloc, WordsState> _buildExpanded() {
    return BlocBuilder<WordsBloc, WordsState>(
      builder: (BuildContext context, WordsState state) {

        if (state is WordsLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is WordsLoaded) {

          final words = state.words;

          return Container(
            height: 1900,
            child: ListView.builder(  
              itemCount: words.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 20.0),
                child: Text(
                  words[index].word,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            )
          );
        }

        if (state is WordsError) {
          return _buildErrorMessage('There was an unknown error.');
        }

        return _buildErrorMessage('Something Unexpected Happened. Did not work.');
      }
    );
  }

  BlocBuilder<RoutesBloc, RoutesState> _buildBlocBuilder() {
    return BlocBuilder<RoutesBloc, RoutesState>(
      builder: (BuildContext context, RoutesState state) {        
        return VocabularyBuilderContainer(
          appBar: true,
          appBarName: state.route,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;
    final double space = isSmall 
    ? 0
    : deviceWidth / 30;
  
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: space),
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: ListView(
          children: <Widget>[
            _buildBlocBuilder(),
            _buildExpanded()
          ],
        )
      ),
    );
  }
}
