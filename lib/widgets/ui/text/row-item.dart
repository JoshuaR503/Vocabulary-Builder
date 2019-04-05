import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:vocabulary_builder/utils/colors.dart';
import 'package:vocabulary_builder/model/main.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
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
        onLongPress: () => _copy(
          text: subtitle,
          context:context, 
          model: model
        ),
        // onTap: () => model.speak(
        //   text: subtitle,
        //   lang: model.speechLang
        // ),
        child: text
      );
      
    } else {
      content = GestureDetector(
        onLongPress: () => _copy(
          text: subtitle,
          context:context, 
          model: model
        ),
        child: text
      );
    }

    return content;
  }

  void _copy({String text, BuildContext context, MainModel model}) {
    ClipboardManager.copyToClipBoard(subtitle)
      .then((result) {
        _createSnackBar(
          title: FlutterI18n.translate(context, 'snackbar.success_message_clipboard'),
          label: FlutterI18n.translate(context, 'snackbar.success_message_clipboard_label'),
          context: context
        );

        model.sendFeedback(false);
      })
      .catchError((error) {
        _createSnackBar(
          title: FlutterI18n.translate(context, 'snackbar.error_message_clipboard'),
          label: FlutterI18n.translate(context, 'snackbar.error_message_clipboard_label'),
          context: context
        );

        model.sendFeedback(true);
      });
  }

  void _createSnackBar({String title, String label, BuildContext context,}) {
    final snackBar = SnackBar(
      content: Text(title),
      action: SnackBarAction(
        label: label,
        onPressed: () {},
      ),
    );
    
    Scaffold.of(context).showSnackBar(snackBar);
  } 
}