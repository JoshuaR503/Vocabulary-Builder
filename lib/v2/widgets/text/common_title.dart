import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';

class CommonTitle extends StatelessWidget {

  final String title;

  CommonTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 20, bottom: 6),
      child: Text(
        title,
        style: TextStyles.commonTitleStyle
      ),
    );
  }
}