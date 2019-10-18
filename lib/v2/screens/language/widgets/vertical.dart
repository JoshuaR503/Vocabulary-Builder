import 'package:flutter/cupertino.dart';
import 'package:vocabulary_builder/v2/screens/language/widgets/button.dart';
import 'package:vocabulary_builder/v2/screens/language/widgets/title.dart';

class VerticalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 650.0 : deviceWidth;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ListView(

        children: <Widget>[

          LanguageTitle(),
          
          SizedBox(height: 40),
  
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Button('English', null, targetWidth),
          ),
  
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Button('Spanish', null, targetWidth),
          )
        ],
      ),
    );
  }
}