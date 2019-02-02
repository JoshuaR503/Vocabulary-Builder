import 'package:flutter/material.dart';
import './divider.dart';

class ListCell extends StatelessWidget {
  final Widget leading, trailing;
  final String title, subtitle;
  final VoidCallback onTap;

  ListCell({
    this.leading,
    this.trailing,
    this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      leading: leading,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
          ),
          Separator.spacer(height: 6.0),
        ],
      ),
      subtitle: Text(subtitle,
        style: Theme.of(context)
          .textTheme
          .subhead
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class MissionNumber extends StatelessWidget {
  final String missionNumber;

  MissionNumber(this.missionNumber);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Text(
        missionNumber,
        style: TextStyle(fontSize: 15.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}