import 'package:flutter/material.dart';

class VocabularyBuilderMessage extends StatelessWidget {

  const VocabularyBuilderMessage({
    this.message
  }) : assert(message != null);

  final String message;

  @override
  Widget build(BuildContext context) {
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
}