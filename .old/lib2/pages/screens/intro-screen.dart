import 'package:flutter/material.dart';

import '../../model/main.dart';
import '../../widgets/ui/elements/slider.dart';

class IntroScreen extends StatefulWidget {

  final MainModel model;
  IntroScreen(this.model);

  @override
    State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  List<Slide> slides = List();

  @override
  void initState() {
    super.initState();

    slides.add(
       Slide(
        title: "VOCABULARIO",
        description: "¡Puedes aprender nuevas palabras todos los días!",
        pathImage: 'assets/books.png',
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
       Slide(
        title: "SIMPLE",
        description: "¡Con un solo toque puedes guardar tantas palabras como quieras!",
        pathImage: 'assets/heart.png',
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      Slide(
        title: "ALTA CALIDAD",
        description: "El contenido que se muestra es lo más preciso posible, sin anuncios y una interfaz limpia.",
        pathImage: 'assets/shield.png',
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
    IntroSlider(
      slides: slides,
      onDonePress: () => widget.model.setData().then((_) => Navigator.pushReplacementNamed(context, '/home')),
      onSkipPress: () => widget.model.setData().then((_) => Navigator.pushReplacementNamed(context, '/home')),
    );
}