import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/widgets/ui/separator.dart';

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
      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Text(
            title,
            style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400),
          ),
          
          Separator.spacer(height: 6.0),
        ],
      ),

      leading: leading,

      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.white70,
          fontFamily: 'Heebo',
          fontWeight: FontWeight.w500,
        )
      ),

      trailing: trailing,
      onTap: () => onTap(),
    );
  }
}