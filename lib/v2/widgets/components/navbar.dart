import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class VocabularyBuilderNavbar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final double height;

  VocabularyBuilderNavbar({ 
    this.title,
    this.height
   });
   
  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmall = screenSize.width <= 479;
    final int by = isSmall ? 5 : 10;
    final double size = Platform.isIOS 
    ? screenSize.width * 0.66
    : screenSize.width * 0.56;

    
    final double appBarTop = size / by;
    final double twentysSix = 26;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: twentysSix, 
          right: twentysSix,
          bottom: twentysSix,
          top: appBarTop
        ),// <- change that
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
      ),
    );
  }
}