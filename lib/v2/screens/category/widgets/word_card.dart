
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/word.dart';

class WordCard extends StatefulWidget {
  const WordCard({
    @required this.word, 
    @required this.index,
    Key key,
    this.onPress,
  }) : super(key: key);

  final int index;
  final Function onPress;
  final Word word;

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  
  void _playAudio() async {
    final AudioPlayer audioPlayer = AudioPlayer();
    final String audio = widget.word.en.wordPronuntiation;
    
    await audioPlayer
    .play(audio)
    .catchError((error) => print('Error: $error'));
  }

  void _changeScreen() async {
    Navigator
      .of(context)
      .push(MaterialPageRoute(
        builder: (context) => WordScreen(word: this.widget.word)
      ));
  }

  Widget _buildMaterialButton({Widget child, Function onPressed}) {
    final ShapeBorder shape = RoundedRectangleBorder( borderRadius: BorderRadius.circular(10));

    return MaterialButton(
      minWidth: 2,
      elevation: 2,
      color: widget.word.color,
      shape: shape,
      onPressed: onPressed,
      child: child
    );
  }

  List<Widget> _buildRigthColumn() {
    return [
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: _buildMaterialButton(
          onPressed: _playAudio,
          child: Icon(
            Icons.volume_up,
            color: Colors.white,
          ),
        )
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: _buildMaterialButton(
          onPressed: _changeScreen,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ), 
        )
      )
    ];
  }

  List<Widget> _buildLeftColumn(bool isSmall) {
    final int maxLines = isSmall ? 2 : 1;

    return [
      Padding(
        padding: EdgeInsets.only(left: 30.0, top: 20),
        child: Text(
          this.widget.word.en.word,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 25.0, 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 30.0, top: 20),
        child: Text(
          this.widget.word.es.word,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: 20.0, 
            fontWeight: FontWeight.w300
          ),
        ),
      ),
    ];
  }

  Widget _buildCard(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isSmall = size.width <= 479;

    final Column leftColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildLeftColumn(isSmall)
    );
    
    final Column rightColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _buildRigthColumn()
    );

    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          children: <Widget>[
            Expanded(child: leftColumn, flex: 10),
            Expanded(child: rightColumn, flex: 5),
            Expanded(child: Container(width: 1.0))
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard(context);
  }
}
