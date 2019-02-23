import 'package:flutter/material.dart';

import '../../utils/settings.dart';
import '../../model/main.dart';
import '../../widgets/ui/elements/slider.dart';

class IntroScreen extends StatefulWidget {

  final MainModel model;
  IntroScreen(this.model);

  @override
    State<StatefulWidget> createState() => _IntroScreenState ();
}

class _IntroScreenState extends State<IntroScreen> {

  List<Slide> slides = List();

  @override
  void initState() {
    super.initState();

    slides.add(
       Slide(
        title: "VOCABULARIO",
        description: "Aumenta tu vocabulario con palabras al azar todo el tiempo.",
        pathImage: 'assets/books.png',
        backgroundColor: Color(0xfff5a623),
      ),
    );

    slides.add(
       Slide(
        title: "MODO OFFLINE",
        description: "Si te gusta una palabra, toca el corazón junto a ella para verla sin conexión.",
        pathImage: 'assets/shield.png',
        backgroundColor: Color(0xff203152),
      ),
    );

    slides.add(
       Slide(
        title: "APRENDE A TU RITMO",
        description: "Con 15 minutos al día puedes aprender nuevas palabras.",
        pathImage: 'assets/idea.png',
        backgroundColor: Color(0XFFC41E3D),
      ),
    );
    // slides.add(
    //   Slide(
    //     title: "ALTA CALIDAD",
    //     description: "El contenido que se muestra es lo más preciso posible, sin anuncios y una interfaz limpia.",
    //     pathImage: 'assets/shield.png',
    //     backgroundColor: Color(0XFF732289),
    //   ),
    // ); 
  }

  @override
  Widget build(BuildContext context) =>
    IntroSlider(
      slides: slides,
      onDonePress: () => widget.model.setData().then((_) => Navigator.pushReplacementNamed(context, '/home')),
      onSkipPress: () => widget.model.setData().then((_) => Navigator.pushReplacementNamed(context, '/home')),
    );
}