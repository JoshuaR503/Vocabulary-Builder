import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LanguageTitle extends StatelessWidget {

  double _getRightFontSize(double deviceWidth, double deviceHeight) {

    final bool isSmallPhone = deviceWidth < 321 && deviceHeight < 540;
    final bool isPhone = deviceWidth < 415;
    final bool isPhoneLandscape = deviceWidth < 800 && deviceHeight < 420;

    if (isSmallPhone) {
      return 30;
    }
    
    if (isPhone || isPhoneLandscape) {
      return 43;
    }

    return 50;
  }
  
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    final double targetWidth = deviceWidth > 768.0 ? 650.0 : deviceWidth;

    final double fontSize = _getRightFontSize(deviceWidth, deviceHeight);
    
    return Container(
      width: targetWidth,
      padding: EdgeInsets.only(top: deviceHeight / 6),
      child: Text(FlutterI18n.translate(context, 'language.title'),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}