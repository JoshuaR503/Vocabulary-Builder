import 'package:flutter/material.dart';

import '../widgets/palabra/single-palabra-card.dart';
import '../widgets/ui/head-card.dart';
import '../widgets/ui/text/row-item.dart';
import '../widgets/ui/divider.dart';
import '../model/palabra.model.dart';
import '../model/main.dart';

class SinglePalabraScreen extends StatelessWidget {
  final Palabra _palabra;
  final MainModel model;

  SinglePalabraScreen(this._palabra, this.model);

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

        body: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[              
                    _buildPalabraBasicInfoCard(),
                    Separator.spacer(),
                    _buildConjugationCard(tipo: _palabra.tipo),
                    
                    _buildPalabraDefinitionCard(definicion: _palabra.definicion, definicionEs: _palabra.definicionEs),
                    Separator.spacer(),
                    _builPalabraExamplesCard(),
                    Separator.spacer(),
                    _buildPalabraAntSynCard(),                
                  ]
                ),
              ),
            )
          ],
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

  Widget _buildConjugationCard({String tipo}) {

    Widget card = Container();

    if (tipo == 'Verbo') {
      card = SinglePalabraCard(
        title: 'Conjugación de ${_palabra.palabra}',
        body: Column(
          children: <Widget>[
            
            RowItem.textRow(
              'Presente Continuo',
              _palabra.presenteContinuo ?? _palabra.presenteContinuo,
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Tercera Persona',
              _palabra.thirdPerson ?? _palabra.thirdPerson,
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Presente',
              _palabra.presente ?? _palabra.presente,
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Pasado', 
              _palabra.pasado ?? _palabra.pasado,
            ),
            Separator.spacer(),
            RowItem.textRow(
              'Futuro', 
              _palabra.futuro ?? _palabra.futuro,
            ),
          ],
        ),
      );
    } 

    return card;
  }

  Widget _buildPalabraDefinitionCard({String definicion, String definicionEs}) {

    Widget card = Container();

    if (definicion != null && definicionEs != null) {
      card = Column(
        children: <Widget>[
          Separator.spacer(),

          HeadCard (
            title: 'Breve definición:',
            subtitle: _palabra.definicion == null ? 'No disponible' : _palabra.definicion,
            title2: 'Breve definición en Español:',
            subtitle2: _palabra.definicionEs == null ? 'No disponible' : _palabra.definicionEs,
          )
        ],
      );
    }

    return card;
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

    Widget card = Container();

    if (_palabra.antonimos == null && _palabra.sinonimos == null) {
      card = Container();
    } else  {
      card = HeadCard(
        title: 'Anotinmos:',
        subtitle: _palabra.antonimos == null ? 'No disponible' : _palabra.antonimos,
        title2: 'Sinonimos:',
        subtitle2: _palabra.sinonimos == null? 'No disponible' : _palabra.sinonimos
      ); 
    }

    return card;
  }
}