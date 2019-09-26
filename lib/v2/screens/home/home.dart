import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/config.dart';
import 'package:vocabulary_builder/v2/screens/home/widgets/category_list.dart';
import 'package:vocabulary_builder/v2/screens/home/widgets/search.dart';
import 'package:vocabulary_builder/v2/widgets/components/container.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildContent() {
    return VocabularyBuilderContainer(
      children: <Widget>[        
        SizedBox(height: 80),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            appName,
            style: TextStyle(
              fontSize: 32,
              height: 0.6,
              fontWeight: FontWeight.w900,
            ),
          )
        ),

        SizedBox(height: 40),
        VocabularyBuilderSearch(),

        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: CategoryList()
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;
    final double space = isSmall 
    ?  0
    : deviceWidth / 30;
  
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: space),
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: ListView(
          children: <Widget>[
            _buildContent(),
          ],
        )
      ),
    );
  }
}
