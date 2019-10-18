import 'package:flutter/material.dart';

import 'package:vocabulary_builder/v2/screens/language/widgets/horizontal.dart';
import 'package:vocabulary_builder/v2/screens/language/widgets/vertical.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  Widget _buildLayoutBuilder() {
    return LayoutBuilder(
      builder: (context, constrains) {
        if (constrains.maxWidth < 450 ) {
          return VerticalLayout();
        } else {
          return HorizontalLayout();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: SafeArea(
        child: _buildLayoutBuilder(),
      )
    );
  }  
}
