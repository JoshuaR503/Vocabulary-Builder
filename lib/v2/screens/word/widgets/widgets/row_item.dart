import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';

class RowItem extends StatelessWidget {

  final String title;
  final String subtitle;

  RowItem({this.title, this.subtitle}) :
    assert(title != null),
    assert(subtitle != null);

  final TextStyle titleStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  final TextStyle subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w100,
    color: AppFontColors.secondaryText
  );

  @override
  Widget build(BuildContext context) {

    final Column leftColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: titleStyle,
        ),
      ]
    );

    final Column rightColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: subtitleStyle,
        ),
      ]
    );

    // final Column pronunciationColumn = Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     MaterialButton(
    //       minWidth: 2,
    //       elevation: 2,
    //       color: AppCardColors.backgroundColor,
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //       onPressed: () {},
    //       child: Icon(Icons.volume_up)
    //     ),
    //   ]
    // );


    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: leftColumn, flex: 2),
              Expanded(child: rightColumn, flex: 2),
              // Expanded(child: pronunciationColumn, flex: 1)
            ],
          ),
        ],
      ),
    );
  }
}
