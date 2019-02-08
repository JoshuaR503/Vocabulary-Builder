import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';

import '../../pages/palabra-single-screen.dart';
import '../../model/palabra_guardada.model.dart';
import '../../model/palabra.model.dart';
import '../../utils/db.helper.dart';
import '../../utils/settings.dart';

class PalabraCard extends StatefulWidget {
  final Palabra palabra;
  
  PalabraCard(this.palabra);

  @override
    State<StatefulWidget> createState() => _PalabraCardState();
}

class _PalabraCardState extends State<PalabraCard> with TickerProviderStateMixin {

  final DatabaseHelper helper = DatabaseHelper();
  final FlutterTts flutterTts = new FlutterTts();

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }
  
 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SinglePalabraScreen(widget.palabra)),
      ),

      child: Card(
        child: Column(
          children: <Widget>[
            _buildDataRow(context),
            _buildActionButtons(context)
          ],
        ),
      )
    );
  } 

  Widget _buildButtonBar() {
    TextStyle style = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300);

    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () => _save(
            palabra: widget.palabra.palabra,
            traduccion: widget.palabra.traduccion,
            definicion: widget.palabra.definicion,
            definicionEs: widget.palabra.definicionEs,
            sinonimos: widget.palabra.sinonimos,
            antonimos: widget.palabra.antonimos,
            ejemplos: widget.palabra.ejemplos,
            tipo: widget.palabra.tipo,
            context: context
          ),
          child: Row(
            children: <Widget>[
              Padding(
                child: Text(widget.palabra.palabra, style: style),
                padding: EdgeInsets.only(right: 2.0),
              ),
              Icon(Icons.bookmark_border),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDataRow(BuildContext context) {

    return FadeTransition(
      opacity: _animation,
      child: Container(
        
        padding: EdgeInsets.all(10.0),
        width: double.infinity,

        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(7.0),

            child: Container(

              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  _buildButtonBar(),

                  SizedBox(height: 4.0),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(widget.palabra.traduccion),
                  )
                ],
              ),
            ),
          )
        )
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    String palabra = widget.palabra.palabra;

    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () => _speak(palabra),     
          child: Row(
            children: <Widget>[
              Padding(
                child: Text(
                  buttonName,
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

  void _speak(String text) { 
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.8);
    flutterTts.speak(text);
  }

  void _save({
    String palabra, 
    String traduccion, 
    String definicion, 
    String definicionEs, 
    String sinonimos, 
    String antonimos, 
    String ejemplos, 
    String tipo, 
    BuildContext context
  }) async {

    int result;

    PalabraGuardada singlePalabra = PalabraGuardada(
      palabra: palabra,
      traduccion: traduccion,
      definicion: definicion,
      definicionEs: definicionEs,
      sinonimos: sinonimos,
      antonimos: antonimos,
      ejemplos: ejemplos,
      tipo: tipo,      
      date: DateFormat.yMMMd().format(DateTime.now())
    );

    result = await helper.savePalabra(singlePalabra);

    if (result != 0) {
      _buildSnackBar(context, success: true);
    } else {
      _buildSnackBar(context, success: false);
    } 
  }

  void _buildSnackBar(BuildContext context, {bool success}) {
    
    Widget snackbar = Container();

    if(success) {
      snackbar = SnackBar(content: Text(onSuccessMessage));
    } else {
      snackbar = SnackBar(content: Text(onErrorMessage));
    }

    Scaffold.of(context).showSnackBar(snackbar);
  }
  
}