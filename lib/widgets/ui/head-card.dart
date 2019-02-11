import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import './divider.dart';

class HeadCard extends StatelessWidget {
  final String title, subtitle;
  final String title2, subtitle2;

  HeadCard({
    @required this.title,
    @required this.subtitle,
    @required this.title2,
    @required this.subtitle2,
  });

  final style = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 17.0
  );

  final subStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    color: secondaryText
  );

  @override
  Widget build(BuildContext context) {
    
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
                  _buildSubtitle(data: subtitle),

                  Separator.spacer(height: 12.0),
                  Separator.spacer(height: 12.0),

                  Text(title2, style: style),
                  Separator.spacer(height: 12.0),
                  _buildSubtitle(data: subtitle2)
                ],
              ),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _buildSubtitle({String data}) {
    Widget content = Container();

    if (data != null) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data,
            style: subStyle
          )
        ],
      );
    }

    return content;
  }
}