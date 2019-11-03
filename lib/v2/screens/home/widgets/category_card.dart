import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/category.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard(
    this.category, {
    Key key,
    this.onPress,
  }) : super(key: key);

  final WordCategory category;
  final Function onPress;

  Widget _buildCardContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          category.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w100,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildShadow(double itemWidth) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 8,
        width: itemWidth * 0.85,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              color: category.color,
              offset: Offset(0, -5),
            ),
          ],
          borderRadius: BorderRadius.circular(25.0)
        ),
      ),
    );
  }

  Widget _buildButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(0),
      
      color: category.color,
      splashColor: Colors.white10,
      highlightColor: Colors.white10,

      elevation: 0,
      highlightElevation: 9,

      disabledColor: category.color,
      onPressed: onPress,

      child: Container(
        height: 100,
        child: _buildCardContent(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {

        final double itemWidth = constrains.maxWidth;

        return Stack(
          children: <Widget>[
            _buildShadow(itemWidth),
            _buildButton()
          ],
        );
      },
    );
  }
}
