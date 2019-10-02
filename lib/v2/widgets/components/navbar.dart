import 'package:flutter/material.dart';

class VocabularyBuilderNavbar extends StatelessWidget {

  final String title;

  VocabularyBuilderNavbar({ this.title });

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final double size = screenSize.width * 0.66;
    final double top = -(screenSize.width * 0.126);
    final double appBarTop = size / 2 + top - IconTheme.of(context).size / 2;
    final double twentysSix = 26;

    return Padding(
      padding: EdgeInsets.only(
        left: twentysSix, 
        right: twentysSix,
        bottom: twentysSix,
        top: appBarTop
      ), // <- change that
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[   

          InkWell(
            child: Icon(Icons.arrow_back),
            onTap: Navigator.of(context).pop,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: twentysSix), // <- change 
            child: Text(
              title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }
}