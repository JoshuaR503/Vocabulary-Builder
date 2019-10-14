
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/widgets/components/card.dart';

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

class _VocabularyBuilderGridState extends State<VocabularyBuilderGrid> {

  void _deleteWord({Word word}) {

    print(word.wordId);

    BlocProvider
      .of<WordBloc>(context)
      .dispatch(DeleteWordEvent(word: word));
  } 

  void _playAudio(String audio) async {
    final AudioPlayer audioPlayer = AudioPlayer();

    await audioPlayer
    .play(audio)
    .catchError((error) => print('Error: $error'));
  }

  Widget _buildVocabularyBuilderCard(Word word) {
    return VocabularyBuilderCard(
      word: word,
      topIcon: widget.topIcon,
      bottomIcon: widget.bottomIcon,
      onPressed: () {
        if (widget.methodName == 'audio') _playAudio(word.en.wordPronuntiation);
        if (widget.methodName == 'delete') _deleteWord(word: word);
      }
    );
  }

  Widget _buildGridView() {
    final Size size = MediaQuery.of(context).size;

    final bool isSmall = size.width <= 479;

    final double width = size.width;
    final double childAspectRatio = isSmall 
    ? width / 180
    : width / 360;

    final int length = this.widget.words.length;
    final int crossAxisCount = isSmall ? 1 : 2;

    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      itemCount: length,
      itemBuilder: (context, index) {
        final Word word = this.widget.words[index];        

        return _buildVocabularyBuilderCard(word);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGridView();
  }
}
