import 'package:flutter/material.dart';

import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/screens/help/help.dart';

class QuestionIcon extends StatelessWidget {

  final int initialIndex;

  QuestionIcon({
    @required this.initialIndex,
  }) : assert(initialIndex != null);
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Image.asset(
        'assets/pictures/thinking.png',
        height: 50.0,
        width: 50.0,
      ),
      onPressed: () =>
        Navigator
        .of(context)
        .push(MaterialPageRoute(
          builder: (context) => HelpScreen(
            color: AppColors.red, 
            initialIndex: this.initialIndex
          )
        )),
    );
  }
}