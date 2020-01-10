import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VocabularyBuilderContainer extends StatelessWidget {

  const VocabularyBuilderContainer({
    Key key,
    this.height,
    this.navbar,
    this.children,
  }) : super(key: key);

  final double height;
  final Widget navbar;
  final List<Widget> children;
  
  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        width: screenSize.width,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children
            ),
          ],
        ),
      ),
    );
  }
}
