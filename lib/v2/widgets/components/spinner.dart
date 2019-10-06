import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VocabularyBuilderSpinner extends StatelessWidget {
  
  final Color color;

  VocabularyBuilderSpinner({
    this.color
  }) : assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(this.color),
      )
    );
  }
}
