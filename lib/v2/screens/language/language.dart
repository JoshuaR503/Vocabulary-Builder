import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/screens/language/widgets/layout.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {  
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppCardColors.backgroundColor,
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
      )
    );
  }  
}
