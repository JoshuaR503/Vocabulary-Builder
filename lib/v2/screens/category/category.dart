import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/routes/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/category/widgets/word_card.dart';
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

  Widget _createWordsCard(List<Word> words) {

    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    final bool isSmall = width <= 479;    
    final int crossAxisCount = isSmall ? 1 : 2;
    final double childAspectRatio = isSmall 
    ? width / 180
    : width / 330;


    final double containerHeight = isSmall
    ? height / 1.25
    : height / 1.5;
    
    // final double containerHeight = isSmall
    // ?  isAndroid ? height / 1.25  : height / 1.22
    // :  isAndroid ? height / 1.8   : height / 1.4;

    return Container(
        height: containerHeight,
        child: GridView.builder(        
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),

          padding: EdgeInsets.only(left: 28, right: 28),

          itemCount: words.length,
          itemBuilder: (context, index) => WordCard(
            words[index],
            index: index,
            onPress: () {},
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

          final List<Word> words = state.words;
          final Size size = MediaQuery.of(context).size;

          return _createWordsCard(words);
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
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: Column(
          children: <Widget>[
            _buildAppbar(),
            _buildExpanded(),
          ],
        )
      ),
    );
  }
}
