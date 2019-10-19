import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/config.dart';

import 'package:vocabulary_builder/v2/screens/home/widgets/category_list.dart';
import 'package:vocabulary_builder/v2/screens/home/widgets/container.dart';
import 'package:vocabulary_builder/v2/screens/home/widgets/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this
    );

    animation = CurvedAnimation(
      parent: controller, 
      curve: Curves.decelerate
    );

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildAppTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        appName,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
        ),
      )
    );
  }

  Widget _buildContent() {
    return VocabularyBuilderContainer(
      children: <Widget>[        
        SizedBox(height: 60),
        _buildAppTitle(),

        SizedBox(height: 40),
        VocabularyBuilderSearch(),

        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: CategoryList(),
        )
      ],
    );
  }

  Widget _buildButton() {
    return FloatingActionButton(
      child: Icon(Icons.settings),
      onPressed: () {
        Navigator
        .of(context)
        .pushNamed('/settings');
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    final bool isSmall = deviceWidth < 480 && deviceHeight < 200;
    final bool isBig = deviceWidth >= 890.0;
  
    final double smallWidth = deviceWidth / 30;
    final double bigWidth = deviceWidth / 10;
    final double horizontal = isSmall 
    ? smallWidth : isBig 
    ? bigWidth : 0;

    return Scaffold(
      body: FadeTransition(
        opacity: animation,
        child:  Container(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          decoration: BoxDecoration(color: Theme.of(context).accentColor),
          child: ListView(
            children: <Widget>[
              _buildContent()
            ],
          )
        ),
      ),
      floatingActionButton: _buildButton()
    );
  }
}
