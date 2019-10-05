import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class VocabularyBuilderNavbar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final double height;

  const VocabularyBuilderNavbar({ 
    this.title,
    this.height
   });
   
  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final bool heightSmall = screenSize.height <= 740 && screenSize.width  <= 479;

    final bool isAndroid = Platform.isAndroid;
    final double top = isAndroid ? 40 : 26;
    final double bottom =  isAndroid ? 15  : heightSmall ? 26 : 0;    
    final double horizontal = 26;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: top,
          left: horizontal,
          right: horizontal,
          bottom: bottom
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[   
            InkWell(
              child: Icon(Icons.arrow_back),
              onTap: Navigator.of(context).pop,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontal), // <- change 
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
      ),
    );
  }
}