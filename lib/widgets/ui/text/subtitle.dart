import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {

  final String subTitle;

  SubTitle(this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, bottom: 10),
      child: Text(
        subTitle,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: Colors.white70
        ),
      ),
    );
  }
}
