import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/palabra-guardada/palabra-guardada.dart';
import '../model/main.dart';
import '../utils/settings.dart';

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
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {

        Widget content = Center(child: Text(onNoSavedWords));

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
    return Scaffold(
      appBar: AppBar( 
        title: Text(savedSection),
        centerTitle: true,
      ),
      body: _buildMainContent(),
    );
  }
}