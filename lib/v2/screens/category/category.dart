import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/widgets/components/container.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

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
      appBar: true,
      appBarName: 'Nouns',
    );
  }

  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;
    final double space = isSmall 
    ? 0
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
