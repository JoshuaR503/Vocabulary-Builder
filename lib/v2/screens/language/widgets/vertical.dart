import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/screens/language/widgets/button.dart';

class VerticalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double targetWidth = deviceWidth > 768.0 ? 650.0 : deviceWidth;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ListView(

        children: <Widget>[
          
          Container(
            width: targetWidth,
            padding: EdgeInsets.only(top: height / 6),
            child: Text(FlutterI18n.translate(context, 'welcome_screen.title'),
              style: TextStyle(
                fontSize: 46.0,
                fontWeight: FontWeight.bold
              )
            ),
          ),
  
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