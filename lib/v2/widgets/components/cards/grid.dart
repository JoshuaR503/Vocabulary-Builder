
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';
import 'package:vocabulary_builder/v2/core/functions.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/widgets/components/cards/card.dart';
import 'dart:async';

class VocabularyBuilderGrid extends StatefulWidget {
  
  const VocabularyBuilderGrid({
    @required this.words,
    @required this.methodName,
    @required this.topIcon,
    @required this.bottomIcon

  }) : assert(words != null),
       assert(methodName != null),
       assert(topIcon != null),
       assert(bottomIcon != null);

  final List<Word> words;
  final String methodName;
  final Icon topIcon;
  final Icon bottomIcon;
  
  @override
  _VocabularyBuilderGridState createState() => _VocabularyBuilderGridState();
}

class _VocabularyBuilderGridState extends State<VocabularyBuilderGrid>  with TickerProviderStateMixin {

  final VocabularyBuilderFunctions functions = VocabularyBuilderFunctions();

  AnimationController controller;
  Animation<double> animation;


  bool _isPlaying = false;
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this
    );

    animation = CurvedAnimation(
      parent: controller, 
      curve: Curves.easeIn
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _changeState(bool value) {
    setState(() {
       _isPlaying = value;
      _isButtonDisabled = value; 
    });
  }

  void callbackManager() {
    Timer(Duration(seconds: 1), () => _changeState(false));
  }
  
  // Methods
  void _deleteWord({Word word}) {
    // Delete audio files
    functions.deleteFile(word.targetLanguage.wordPronuntiation);
    functions.deleteFile(word.firstLanguage.wordPronuntiation);

    BlocProvider
      .of<WordBloc>(context)
      .add(DeleteWordEvent(word: word));
  }

  // Actual Widgets
  Widget _buildVocabularyBuilderCard(Word word) {
    return VocabularyBuilderCard(
      word: word,
      topIcon: widget.topIcon,
      bottomIcon: widget.bottomIcon,
      onPressed: _isButtonDisabled ? () {} : () {
        if (widget.methodName == 'delete') _deleteWord(word: word);
        if (widget.methodName != 'delete' && !_isPlaying) {
          _changeState(true);

          functions
          .playAudio(
            audio: word.targetLanguage.wordPronuntiation, 
            isLocal: word.isSaved
          )
          .then((_) => callbackManager());
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.of(context).size;
    final bool isSmall = size.width <= 480;

    final double width = size.width;
    final double childAspectRatio = isSmall 
    ? width / 180
    : width / 360;

    final int length = this.widget.words.length;
    final int crossAxisCount = isSmall ? 1 : 2;

    // Widget
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      itemCount: length,
      itemBuilder: (context, index) {
        final Word word = this.widget.words[index];        

        return FadeTransition(
          opacity: animation,
          child: _buildVocabularyBuilderCard(word)
        );
      }
    );
  }
}
