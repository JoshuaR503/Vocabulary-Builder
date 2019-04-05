import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:vocabulary_builder/model/main.dart';
import 'package:vocabulary_builder/pages/screens/error-screen.dart';
import 'package:vocabulary_builder/pages/search-screen.dart';
import 'package:vocabulary_builder/widgets/palabra-guardada/palabra-guardada.dart';

class PalabraGuardadaScreen extends StatefulWidget {
  final MainModel model;
  
  PalabraGuardadaScreen(this.model);

  @override
    State<StatefulWidget> createState() => _PalabraGuardadaScreenState();
}

class _PalabraGuardadaScreenState extends State<PalabraGuardadaScreen> {

  @override
    void initState() {
      widget.model.obtenerPalabrasGuardadas();
      super.initState();
    }

  Widget _buildMainContent() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {

        Widget content = ErrorScreen(
          message: FlutterI18n.translate(context, 'error_message.no_saved_words.message'),
          pathImage: 'assets/box.png',
          fixMessage: FlutterI18n.translate(context, 'error_message.no_saved_words.solution')
        );

        if (model.allPalabrasGuardadas.length > 0 && !model.palabrasGuardadasIsLoading) {
          content = PalabrasGuardadas();
        } else if (model.palabrasGuardadasIsLoading) {
          content = Center(child: CircularProgressIndicator());
        }

        return content;
      }
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, 'saved_words.title')),
        centerTitle: true,
        actions: <Widget>[
          Tooltip(
            message: FlutterI18n.translate(context, 'saved_words.appbar.icons.search_tooltip'),child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator
                .of(context)
                .push(searchPalabras(
                  context, 
                  widget.model.allPalabrasGuardadas, 
                  widget.model
                )),
            ),
          ),

        ],
      ),
      body:  _buildMainContent(),
    );
  }
}