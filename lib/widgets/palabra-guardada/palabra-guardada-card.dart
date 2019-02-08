import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../pages/palabra-single-screen.dart';
import '../../model/palabra_guardada.model.dart';
import '../../model/palabra.model.dart';

class PalabraGuardadaCard extends StatefulWidget {
  final PalabraGuardada palabra;

  PalabraGuardadaCard(this.palabra);

  @override
    State<StatefulWidget> createState() => _PalabraGuardadaCardState();
}

class _PalabraGuardadaCardState extends State<PalabraGuardadaCard> with TickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    
    final Palabra singlePalabra =  Palabra(
      palabra: widget.palabra.palabra,
      traduccion: widget.palabra.traduccion,
      definicion: widget.palabra.definicion,
      definicionEs: widget.palabra.definicionEs,
      sinonimos: widget.palabra.sinonimos,
      antonimos: widget.palabra.antonimos,
      ejemplos: widget.palabra.ejemplos,
      alt: false,
      tipo: widget.palabra.tipo,
    );

    return GestureDetector(
      child: Card(
		  	elevation: 2.0,
		  	child: ListTile(
		  		leading: CircleAvatar(
		      	backgroundColor: Colors.amber,
		      	child: Icon(Icons.volume_up, color: Colors.white),
		      ),
          trailing: GestureDetector (
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.arrow_forward, color: Colors.white),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SinglePalabraScreen(singlePalabra)),
            ),
		  	  ),
		  		title: Text(widget.palabra.palabra, style: titleStyle,),
		  		subtitle: Text(widget.palabra.traduccion),
          onTap: () => _speak(widget.palabra.palabra)
		  	),
		  ),
    );
  }

  void _speak(String text) { 
    FlutterTts flutterTts = new FlutterTts();
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.8);
    flutterTts.speak(text);
  }
}