import 'package:flutter/material.dart';

class VocabularyBuilderSolutionMessage extends StatelessWidget {

  const VocabularyBuilderSolutionMessage({
    this.solution
  }) : assert(solution != null);

  final String solution;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Center(
        child: Text(
          solution,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white60,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      )
    );
  }
}