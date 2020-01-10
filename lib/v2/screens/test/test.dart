import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/widgets/components/reusable/container.dart';

class TestScreen extends StatelessWidget {

  TestScreen({
    @required this.title
  }): assert (title != null);

  final String title;

  Widget _buildAppTitle() {
    return Text(
      this.title,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  List<Widget> _buildContent() {
    return [
      VocabularyBuilderContainer(
        children: <Widget>[        
          SizedBox(height: 60),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: _buildAppTitle() 
          ),

          SizedBox(height: 25),

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 32),
          //   child: _buildAppSubTitle() 
          // ),

          SizedBox(height: 40),
        ],
      )
    ];
  }
  
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    final bool isSmall = deviceWidth < 480 && deviceHeight < 200;
    final bool isBig = deviceWidth >= 500.0;
  
    final double smallWidth = deviceWidth / 30;
    final double bigWidth = deviceWidth / 8;
    
    final double horizontal = isSmall 
    ? smallWidth : isBig
    ? bigWidth : 0;

    return Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal ),
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: ListView(
          children: _buildContent()
        )
      ),
    );
  }
}