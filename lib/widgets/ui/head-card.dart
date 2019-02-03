import 'package:flutter/material.dart';

import './divider.dart';

class HeadCard extends StatelessWidget {
  final String title1, subtitle1, title2, subtitle2, title3;
  final List subtitle3;
  // final Widget subtitle2;

  HeadCard({
    this.title1,
    this.subtitle1,
    this.title2,
    this.subtitle2,
    this.title3,
    this.subtitle3,
    // this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 20.0
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

                  Text(title1,style: style),
                  Separator.spacer(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subtitle1)
                    ],
                  ),
                  Separator.spacer(height: 12.0),

                  Text(title2,style: style),
                  Separator.spacer(height: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(subtitle2)
                    ],
                  ),
                  Separator.spacer(height: 12.0),

                  Text(title3, style: style),
                  Separator.spacer(height: 12.0),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text(subtitle3.toString())
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
