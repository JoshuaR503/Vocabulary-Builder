import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/screens/language/widgets/layout.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constrains) {
            if (constrains.maxWidth < 450 ) {
              return LanguageLayout(layout: 'vertical');
            } else {
              return LanguageLayout(layout: 'horizontal');
            }
          },
        )
      )
    );
  }  
}
