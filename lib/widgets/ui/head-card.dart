import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import './divider.dart';

class HeadCard extends StatelessWidget {
  final String title, subtitle;
  final String title2, subtitle2;

  HeadCard({
    this.title,
    this.subtitle,
    this.title2,
    this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 17.0
    );

    final subStyle = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      color: secondaryText
    );

    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(title, style: style),
                  Separator.spacer(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subtitle, style: subStyle)
                    ],
                  ),

                  Separator.spacer(height: 12.0),
                  Separator.spacer(height: 12.0),

                  Text(title2, style: style),
                  Separator.spacer(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subtitle2, style: subStyle)
                    ],
                  ),

                ],
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}