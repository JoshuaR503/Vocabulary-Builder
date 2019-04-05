import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/model/main.dart';
import 'package:vocabulary_builder/utils/colors.dart';
import 'package:vocabulary_builder/widgets/ui/divider.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class HeadCard extends StatelessWidget {
  final String title, subtitle;
  final String title2, subtitle2;
  final MainModel model = MainModel();

  HeadCard({
    @required this.title,
    @required this.subtitle,
    this.title2,
    this.subtitle2,
  });

  final style = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 17.0
  );

  final subStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    color: secondaryText
  );

  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: style),
                  Separator.spacer(height: 12.0),
                  _buildSubtitle(data: subtitle, context: context),

                  Separator.spacer(height: 12.0),
                  Separator.spacer(height: 12.0),

                  Text(title2, style: style),
                  Separator.spacer(height: 12.0),
                  _buildSubtitle(data: subtitle2, context: context)
                ],
              ),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _buildSubtitle({String data, BuildContext context}) {
    
    Widget content = Container();

    if (data != null) {
      content = GestureDetector(
        onLongPress: () => _copy(data, context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(data, style: subStyle)
          ],
        ),
      );
        
    }

    return content;
  }

 void _copy(String text, BuildContext context) {
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