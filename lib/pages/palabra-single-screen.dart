import 'package:flutter/material.dart';

import '../widgets/palabra/single-palabra-card.dart';
import '../widgets/ui/head-card.dart';
import '../widgets/ui/row-item.dart';
import '../widgets/ui/divider.dart';
import '../model/palabra.model.dart';

class SinglePalabraScreen extends StatelessWidget {
  final Palabra _palabra;

  SinglePalabraScreen(this._palabra);

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
      },
        
      child: Scaffold(
        appBar: AppBar( 
          title: Text(_palabra.palabra),
          centerTitle: true,
        ),

        body: Builder(
          builder: (context) => ListView(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(children: <Widget>[
                    _buildPalabraBasicInfoCard(),
                    Separator.spacer(),
                    _buildPalabraDefinitionCard(), 
                    Separator.spacer(),
                    _builPalabraExamplesCard(),
                    Separator.spacer(),
                    _buildPalabraAntSynCard(),
                    Separator.spacer(),
                  ]),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget _buildPalabraBasicInfoCard() {
    return SinglePalabraCard(
      title: 'Detalles adicionales',
      body: Column(
        children: <Widget>[
          RowItem.textRow(
            'Palabra', 
            _palabra.palabra
          ),
          
          Separator.spacer(),
          RowItem.textRow(
            'Traducción',
            _palabra.traduccion
          ),

          Separator.spacer(),
          RowItem.textRow(
            'Categoría gramatical', 
            _palabra.tipo == null ? 'No disponible' : _palabra.tipo,
          ),
        ],
      ),
    );
  }

  Widget _buildPalabraDefinitionCard() {
    return HeadCard(
      title: 'Breve definición:',
      subtitle: _palabra.definicion == null ? 'No disponible' : _palabra.definicion,
      title2: 'Breve definición en Español:',
      subtitle2: _palabra.definicionEs == null ? 'No disponible' : _palabra.definicionEs,
    );
  }

  Widget _builPalabraExamplesCard() {
    return HeadCard(
      title: '${_palabra.palabra} en una oración:',
      subtitle: _palabra.ejemplos == null ? 'No disponible' : _palabra.ejemplos,
      title2: '¿Hay mas traducciones?',
      subtitle2: _palabra.alt == true ? 'Si' : 'No',
    );
  }

  Widget _buildPalabraAntSynCard() {
    return HeadCard(
      title: 'Anotinmos:',
      subtitle: _palabra.antonimos == null ? 'No disponible' : _palabra.antonimos,
      title2: 'Sinonimos:',
      subtitle2: _palabra.sinonimos == null ? 'No disponible' : _palabra.sinonimos,
    );
  }

  
}