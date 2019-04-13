import 'package:flutter/material.dart';

class SinglePalabraCard extends StatelessWidget {
  final String title;
  final Widget body;

  SinglePalabraCard({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
              ),
            ),
            body
          ],
        ),
      ),
    );
  }
}