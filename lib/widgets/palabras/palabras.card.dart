import 'package:flutter/material.dart';
import 'package:moblie/model/main.dart';

import 'package:moblie/model/palabra.model.dart';
import 'package:moblie/pages/palabra-single-screen.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class PalabraCard extends StatelessWidget {
  final Palabra palabra;
  final String language;
  
  PalabraCard(this.palabra, this.language);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant <MainModel> (
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SinglePalabraScreen(palabra))),
          child: Card(
            child: Column(
              children: <Widget>[
                _buildDataRow(context, model, language),
                _buildActionButtons(context, model)
              ],
            ),
          )
        );
      }
    );
  }

  Widget _buildDataRow(BuildContext context, MainModel model, String language) {

    TextStyle style = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300);

    Widget content;
    Widget iconButton = IconButton(
      onPressed: () => _save(context, palabra, model),
      icon: Icon(Icons.favorite_border),
      color: Colors.red,
    );

    content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  child: Text(
                    model.userLang == 'es' ? palabra.traduccion : palabra.palabra,
                    style: style
                  ),
                  padding: EdgeInsets.only(left: 16.0),
                ),
                iconButton
              ],
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(model.userLang == 'es' ? palabra.palabra : palabra.traduccion),
        )
      ],
    );

    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(7.0),
        child: Container(
          height: 120.0,
          child: content
        )
      )
    );
  }

  Widget _buildActionButtons(BuildContext context, MainModel model) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () => model.speak(
            model.userLang == 'es' ? palabra.traduccion : palabra.palabra,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                child: Text(
                  FlutterI18n.translate(context, 'home.button_name'),
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300),
                ),
                padding: EdgeInsets.only(right: 8.0),
              ),
              Icon(Icons.volume_up)
            ],
          ),
        )
      ],
    );
  }

  void _save(BuildContext context, Palabra palabra, MainModel model) async {
    await model
    .save(palabraData: palabra)
    .then((response) {
      if (response != 0) {
         _createSnackBar(
          title: FlutterI18n.translate(context, 'snackbar.success_saving_word'),
          label: FlutterI18n.translate(context, 'snackbar.success_saving_word_label'),
          context: context
        );

        model.sendFeedback(false);
      }
    })
    .catchError((error) {
      _createSnackBar(
        title: FlutterI18n.translate(context, 'snackbar.error_saving_word'),
        label: FlutterI18n.translate(context, 'snackbar.error_saving_word_label'),
        context: context
      );

      model.sendFeedback(true);
    }); 
  }

  void _createSnackBar({String title, String label, BuildContext context}) {
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