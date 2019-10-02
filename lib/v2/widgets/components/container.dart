import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VocabularyBuilderContainer extends StatelessWidget {

  const VocabularyBuilderContainer({
    Key key,
    this.appBar = false,
    this.height,
    this.navbar,
    this.children,
  }) : super(key: key);

  final bool appBar;
  final double height;
  final Widget navbar;
  final List<Widget> children;
  
  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (appBar) this.navbar,
              if (children != null) ...children,
            ],
          ),
        ],
      ),
    );
  }
}
