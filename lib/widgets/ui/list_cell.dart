import 'package:flutter/material.dart';
import 'package:vocabulary_builder/widgets/ui/divider.dart';

class ListCell extends StatelessWidget {
  final Widget leading, trailing;
  final String title, subtitle;
  final Function onTap;

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
      contentPadding: EdgeInsets.symmetric(
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
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.white70
        )
      ),
      trailing: trailing,
      onTap: () => onTap(),
    );
  }
}