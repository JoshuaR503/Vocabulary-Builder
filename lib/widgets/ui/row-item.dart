import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../utils/colors.dart';

class RowItem extends StatelessWidget {
  final String title;
  final Widget description;

  RowItem(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: primaryText),
          ),
          description
        ],
      ),
    );
  }

  factory RowItem.textRow(String title, String description) {
    return RowItem(title, _getText(description));
  }

  factory RowItem.iconRow(String title, bool status) {
    return RowItem(title, _getIcon(status));
  }

  factory RowItem.dialogRow({
    BuildContext context,
    String title,
    String description,
    ScopedModel screen,
  }) {
      return RowItem(title, _getText(description));
  }

  static Widget _getIcon(bool status) {
    return Icon(
      status == null
          ? Icons.remove_circle
          : (status ? Icons.check_circle : Icons.cancel),
      color: status == null ? nullIcon : (status ? acceptIcon : denyIcon),
      size: 19.0,
    );
  }

  static Widget _getText(String description, [bool clickable = false]) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 17.0,
        color: secondaryText,
        decoration: clickable ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
