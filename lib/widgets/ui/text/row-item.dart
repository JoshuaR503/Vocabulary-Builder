import 'package:flutter/material.dart';
import 'package:moblie/utils/colors.dart';
import 'package:moblie/model/main.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class RowItem extends StatelessWidget {
  final String title;
  final String description;
  final bool showButton;
  final MainModel model = MainModel();

  RowItem(this.title, this.description, [this.showButton]);

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
          
          _renderButton(context)
        ],
      ),
    );
  }

  Widget _renderButton(BuildContext context) {

    Widget content;

    if (showButton && showButton != null) {
      content = GestureDetector(
        onTap: () => model.speak(description),
        onLongPress: () => _copy(description, context),
        child: Text(
          description,
          style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(color: secondaryText),
        ),
      );
    } else {
      content = GestureDetector(
        onLongPress: () => _copy(description, context),
        child: Text(
          description,
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
    ClipboardManager.copyToClipBoard(description)
      .then((result) {

        _createSnackBar(
          title: 'Se pegó al portapapeles',
          label: 'Ok!',
          context: context
        );

        model.sendFeedback();
      })
      .catchError((error) => {
        _createSnackBar(
          title: 'Hubo un error al intentar pegar al portapapeles',
          label: 'Ok!',
          context: context
        )
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

  // factory RowItem.textRow(String title, String description, [bool showButton = false]) {
  //   return RowItem(title, _getText(description, showButton));
  // }

  // static Widget _getText(String description, [bool showButton = false]) {

  //   Widget content = Container();

  //   if (showButton) {

  //     content = FlatButton(
  //       onPressed: () {},
  //       child: Text(
  //         description,
  //         style: TextStyle(
  //           fontSize: 17.0,
  //           color: secondaryText,
  //         ),
  //       ),
  //     );

  //   } else {
  //     content = Text(
  //       description,
  //       style: TextStyle(
  //         fontSize: 17.0,
  //         color: secondaryText,
  //       ),
  //     );
  //   }

  //   return content;
  // }
}
