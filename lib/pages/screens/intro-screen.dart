import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../model/main.dart';
import '../../widgets/ui/elements/slider.dart';

class IntroScreen extends StatefulWidget {
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
        description: "Aumenta tu vocabulario con palabras aleatorias de una manera simple.",
        pathImage: 'assets/books.png',
        backgroundColor: Color(0xfff5a623),
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
        title: "JUST TAP IT",
        description: "Si quieres obtener más información de una palabra, simplemente tócala.",        
        pathImage: 'assets/tap.png',
        backgroundColor: Color(0XFF008A73),
      ),
    );    
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return IntroSlider(
          slides: slides,
          onDonePress: () => model.setData().then((_) => Navigator.pushReplacementNamed(context, '/home')),
          onSkipPress: () => model.setData().then((_) => Navigator.pushReplacementNamed(context, '/home')),
        );
      }
    );
  }
}