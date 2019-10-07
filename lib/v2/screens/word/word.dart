import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

class WordScreen extends StatefulWidget {

  final Word word;

  const WordScreen({
    this.word,
  }) : assert(word != null);
  @override
  _WordState createState() => _WordState();
}

class _WordState extends State<WordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: this.widget.word.color,
        title: Text('Single Word Section'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                this.widget.word.word,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 25.0, 
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ), 
      )
    );
  }
}