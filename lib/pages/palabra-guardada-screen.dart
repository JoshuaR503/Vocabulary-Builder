import 'package:flutter/material.dart';
import 'package:moblie/model/main.dart';
import 'package:moblie/pages/screens/error-screen.dart';
import 'package:moblie/pages/search-screen.dart';
import 'package:moblie/utils/settings.dart';
import 'package:moblie/widgets/palabra-guardada/palabra-guardada.dart';
import 'package:scoped_model/scoped_model.dart';

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
          message: onNoSavedWords,
          pathImage: 'assets/box.png',
          fixMessage: onNoSavedWordsFix,
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
        title: Text(savedSection),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator
              .of(context)
              .push(searchPalabras(
                context, 
                widget.model.allPalabrasGuardadas, 
                widget.model
              )),
          )
        ],
      ),
      body:  _buildMainContent(),
    );
  }
}