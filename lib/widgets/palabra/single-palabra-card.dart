import 'package:flutter/material.dart';

class SinglePalabraCard extends StatelessWidget {
  final String title;
  final Widget body;

  SinglePalabraCard({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            body
          ],
        ),
      ),
    );
  }
}
