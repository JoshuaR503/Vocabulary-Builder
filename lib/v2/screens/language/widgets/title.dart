import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LanguageTitle extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double targetWidth = deviceWidth > 768.0 ? 650.0 : deviceWidth;
    
    return Container(
      width: targetWidth,
      padding: EdgeInsets.only(top: deviceHeight / 6),
      child: Text(FlutterI18n.translate(context, 'welcome_screen.title'),
        style: TextStyle(
          fontSize: deviceHeight / 15 * deviceWidth / 400,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}