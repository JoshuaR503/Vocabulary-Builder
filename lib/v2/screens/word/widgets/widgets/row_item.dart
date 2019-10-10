import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';

class RowItem extends StatelessWidget {

  final String title;
  final String subtitle;

  RowItem({this.title, this.subtitle}) :
    assert(title != null),
    assert(subtitle != null);

  final TextStyle titleStyle = TextStyle(
    fontSize: 17.5,
    color: Colors.white,
  );

  final TextStyle subtitleStyle = TextStyle(
    fontSize: 17.5,
    fontWeight: FontWeight.w100,
    color: AppFontColors.secondaryText
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: titleStyle,
          ),

          Text(
            subtitle,
            style: subtitleStyle,
          ),
        ],
      ),
    );
  }
}
