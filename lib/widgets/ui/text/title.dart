import 'package:flutter/material.dart';

class CommonTitle extends StatelessWidget {

  final String title;

  CommonTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 28, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
    );
  }
}

