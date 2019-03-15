import 'package:flutter/material.dart';
import 'package:moblie/utils/colors.dart';
import 'package:moblie/model/main.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:moblie/widgets/ui/divider.dart';

class RowItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool copyClipboard;
  final MainModel model = MainModel();

  RowItem({this.title, this.subtitle, this.copyClipboard});

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
          
          _renderButton(context),
        ],
      ),
    );
  }

  Widget _renderButton(BuildContext context) {

    Widget content;

    if (copyClipboard && copyClipboard != null) {
      content = GestureDetector(
        onTap: () => model.speak(subtitle),
        onLongPress: () => _copy(subtitle, context),
        child: Text(
          subtitle,
          style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(color: secondaryText),
        ),
      );
    } else {
      content = GestureDetector(
        onLongPress: () => _copy(subtitle, context),
        child: Text(
          subtitle,
          style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(color: secondaryText),
        ),
      );
    }

    return content;
  }

  void _copy(String text, BuildContext context) {
    ClipboardManager.copyToClipBoard(subtitle)
      .then((result) {

        _createSnackBar(
          title: 'Se pegó al portapapeles',
          label: 'Ok!',
          context: context
        );

        model.sendFeedback(false);
      })
      .catchError((error) {
        _createSnackBar(
          title: 'Hubo un error al intentar pegar al portapapeles',
          label: 'Ok!',
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