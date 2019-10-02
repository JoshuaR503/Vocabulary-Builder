import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/routes/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';
import 'package:vocabulary_builder/v2/screens/category/widgets/word_card.dart';
import 'package:vocabulary_builder/v2/widgets/components/container.dart';
import 'package:vocabulary_builder/v2/widgets/components/navbar.dart';

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
          final height = MediaQuery.of(context).size.height;

          return Container(
            height: height / 1.3,
            color: Colors.red,
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

  BlocBuilder<RoutesBloc, RoutesState> _buildAppbar() {
    return BlocBuilder<RoutesBloc, RoutesState>(
      builder: (BuildContext context, RoutesState state) {        
        return VocabularyBuilderNavbar(title: state.route);
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildAppbar(),
                _buildExpanded(),
              ],
            )
          ],
        )
        
        // child: ListView(
        //   children: <Widget>[
           
        //     _buildExpanded()
        //   ],
        // )
      ),
    );
  }
}
