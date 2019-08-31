import 'package:flutter/material.dart';

import 'package:vocabulary_builder/utils/colors.dart';
import 'package:vocabulary_builder/model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class RowItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool copyClipboard;

  RowItem({this.title, this.subtitle, this.copyClipboard});

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return  Container(
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

              _renderButton(
                context: context, 
                model: model
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _renderButton({BuildContext context, MainModel model}) {

    Widget content;

    TextStyle style = Theme.of(context)
      .textTheme
      .subhead
      .copyWith(color: secondaryText);
    
    Text text = Text(subtitle, style: style);
    
    if (copyClipboard && copyClipboard != null) {
      content = GestureDetector(
        onTap: null,
        child: text
      );
      
    } else {
      content = GestureDetector(
        child: text
      );
    }

    return content;
  }



}