import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VocabularyBuilderContainer extends StatelessWidget {

  const VocabularyBuilderContainer({
    Key key,
    this.children,
    this.height,
    this.appBar = false,
    this.appBarName,
  }) : super(key: key);

  final bool appBar;
  final List<Widget> children;
  final double height;
  final String appBarName;

  Widget _buildNavbar(BuildContext context, double top) {
    return Padding(
      padding: EdgeInsets.only(left: 26, right: 26, top: top),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          InkWell(
            child: Icon(Icons.arrow_back),
            onTap: Navigator.of(context).pop,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Text(
              appBarName,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final double size = screenSize.width * 0.66;
    final double top = -(screenSize.width * 0.154);
    final double appBarTop = size / 2 + top - IconTheme.of(context).size / 2;

    return Container(
      width: screenSize.width,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (appBar) this._buildNavbar(context, appBarTop),
              if (children != null) ...children,
            ],
          ),
        ],
      ),
    );
  }
}
