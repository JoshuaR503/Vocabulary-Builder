import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  Button(
    this.name,
    this.onTap,
    this.targetWidth
  ) : assert(name != null),
      assert(targetWidth != null);

  final String name;
  final Function onTap;
  final double targetWidth;

  
  double _getRightFontSize(double deviceWidth, double deviceHeight) {

    final bool isSmallPhone = deviceWidth < 321 && deviceHeight < 540;
    final bool isSmallLandscape = deviceWidth < 700;
    final bool isPhone = deviceWidth < 415;

    print(deviceWidth);

    if (isSmallPhone) {
      return 15;
    } else if (isSmallLandscape) {
      return 20;
    } else if (isPhone) {
      return 25;
    }

    return 25;
  }

  double _getRightButtonSize(double deviceWidth, double deviceHeight) {

    final bool isSmallPhone = deviceWidth < 321 && deviceHeight < 540;
    final bool isSmallLandscape = deviceWidth < 540;

    final bool isPhone = deviceWidth < 415;
    final bool isPhoneLandscape = deviceWidth < 800 && deviceHeight < 420;

    if (isSmallPhone) {
      return 40;
    } else if (isSmallLandscape) {
      return 50;
    } else if (isPhone || isPhoneLandscape ) {
      return 55;
    }
    
    return 50;
  }
  
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    final fontSize = _getRightFontSize(deviceWidth, deviceHeight);
    final buttonSize = _getRightButtonSize(deviceWidth, deviceHeight);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: buttonSize,
        width: targetWidth / 3,
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFFfab407),
          
          elevation: 7.0,
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: fontSize, 
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ),
    );
  }
}