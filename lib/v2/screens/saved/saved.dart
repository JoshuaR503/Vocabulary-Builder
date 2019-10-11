
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/styles.dart';

class SavedWordsScreen extends StatefulWidget {
  @override
  _SavedWordsScreenState createState() => _SavedWordsScreenState();
}

class _SavedWordsScreenState extends State<SavedWordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.brown,
        title: Text('Favorite Words Screen'),
        centerTitle: true,
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: SafeArea(
          child: Center(
            child: Text(
              'Favorite Words Screen',
              style: TextStyles.titleStyle,
            ),
          )
        )
      ),
    );
  }
}