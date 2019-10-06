
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/category/widgets/word_card.dart';
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
          return _buildErrorMessage('Section under construction. Come back later');
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
