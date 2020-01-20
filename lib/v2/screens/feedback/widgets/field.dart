import 'package:flutter/material.dart';

class FieldManager extends StatelessWidget {

  final String text;
  final int maxLines;
  final TextEditingController controller;
  final bool isRequired;

  FieldManager({
    this.text,
    this.controller,
    this.maxLines = 1,
    this.isRequired = true
  }) : assert(
    text != null,
    controller != null
  );

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 5),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),

      child: TextFormField(
        maxLines: this.maxLines,
        controller: this.controller,
        decoration: InputDecoration(
          hintText: this.text,
          hintStyle: TextStyle(fontSize: 15.5),
          border: InputBorder.none,
        ),
        

        validator: (value) {

          if (value.isEmpty && this.isRequired) {
            return 'Please enter some text';
          }

          return null;
        },
      )
    );
  }
}