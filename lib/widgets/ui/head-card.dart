import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import './divider.dart';

class HeadCard extends StatelessWidget {
  final String definicion, subDefinicion;
  final String examples, subExamples;
  final String synonyms, subSynonyms;
  final String type, subType;

  HeadCard({
    this.definicion,
    this.subDefinicion,
    this.examples,
    this.subExamples,
    this.synonyms,
    this.subSynonyms,
    this.type,
    this.subType,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 18.0
    );

    final subStyle = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      color: secondaryText
    );

    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(definicion, style: style),
                  Separator.spacer(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subDefinicion, style: subStyle)
                    ],
                  ),

                  Separator.spacer(height: 12.0),
                  Text(examples, style: style),
                  Separator.spacer(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subExamples, style: subStyle)
                    ],
                  ),

                  Separator.spacer(height: 12.0),
                  Text(synonyms, style: style),
                  Separator.spacer(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subSynonyms, style: subStyle)
                    ],
                  ),

                  Separator.spacer(height: 12.0),
                  Text(type, style: style),
                  Separator.spacer(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subType,  style: subStyle)
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
