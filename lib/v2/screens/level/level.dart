import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/screens/level/widgets/layout.dart';

class LevelScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constrains) {
            if (constrains.maxWidth < 450 ) {
              return LevelLayout(layout: 'vertical');
            } else {
              return LevelLayout(layout: 'horizontal');
            }
          },
        )
      )
    );
  }  
}
