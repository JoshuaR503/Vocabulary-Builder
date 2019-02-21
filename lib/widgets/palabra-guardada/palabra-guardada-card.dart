import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:moblie/model/main.dart';
import 'package:moblie/model/palabra.model.dart';
import 'package:moblie/model/palabra_guardada.model.dart';
import 'package:moblie/pages/palabra-single-screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PalabraGuardadaCard extends StatefulWidget {
  final PalabraGuardada palabra;
  final MainModel model;

  PalabraGuardadaCard(this.palabra, this.model);

  @override
    State<StatefulWidget> createState() => _PalabraGuardadaCardState();
}

class _PalabraGuardadaCardState extends State<PalabraGuardadaCard> with TickerProviderStateMixin {

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

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    
    final Palabra singlePalabra =  Palabra(
      palabra: widget.palabra.palabra,
      traduccion: widget.palabra.traduccion,
      pasado: widget.palabra.pasado,
      presente: widget.palabra.presente,
      presenteContinuo: widget.palabra.presenteContinuo,
      thirdPerson: widget.palabra.thirdPerson,
      futuro: widget.palabra.futuro,
      definicion: widget.palabra.definicion,
      definicionEs: widget.palabra.definicionEs,
      sinonimos: widget.palabra.sinonimos,
      antonimos: widget.palabra.antonimos,
      ejemplos: widget.palabra.ejemplos, 
      alt: false,
      nota: widget.palabra.nota,
      tipo: widget.palabra.tipo,
    );

    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
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
                child: Icon(FontAwesomeIcons.handPointUp, color: Colors.white),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SinglePalabraScreen(singlePalabra, widget.model)),
              ),
		    	  ),
            
		    		title: Text(widget.palabra.palabra, style: titleStyle,),
		    		subtitle: Text(widget.palabra.traduccion),
            onTap: () => widget.model.speak(widget.palabra.palabra)
		    	),
		    ),
      ),
    );
  }
}