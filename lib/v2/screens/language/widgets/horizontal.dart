import 'package:flutter/cupertino.dart';
import 'package:vocabulary_builder/v2/screens/language/widgets/button.dart';
import 'package:vocabulary_builder/v2/screens/language/widgets/title.dart';

class HorizontalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 650.0 : deviceWidth; 

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80),
      child: ListView(
        children: <Widget>[

          LanguageTitle(),
  
          SizedBox(height: 40),
  
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Button('English', null, targetWidth),
              Button('Spanish', null, targetWidth),
            ],
          )
        ],
      ),
    );
  }
}