
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';

class TranslatorScreen extends StatefulWidget {
  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.tealAccent,
        title: Text('Translator Screen'),
        centerTitle: true,
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: SafeArea(
          child: Center(
            child: Text(
              'Translator Screen',
              style: TextStyles.titleStyle,
            ),
          )
        )
      ),
    );
  }
}