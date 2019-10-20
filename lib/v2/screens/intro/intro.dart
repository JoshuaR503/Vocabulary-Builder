import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/widgets/ui/slider/slider.dart';

class IntroScreen extends StatefulWidget {

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: [
        Slide(
          title: FlutterI18n.translate(context, 'slide_show.slide_one.title'),
          description: FlutterI18n.translate(context, 'slide_show.slide_one.description'),
          pathImage: 'assets/pictures/books.png',
          backgroundColor: Color(0xfff5a623),
        ),

        Slide(
          title: FlutterI18n.translate(context, 'slide_show.slide_two.title'),
          description: FlutterI18n.translate(context, 'slide_show.slide_two.description'),
          pathImage: 'assets/pictures/idea.png',
          backgroundColor: Color(0XFFC41E3D),
        ),

        Slide(
          title: FlutterI18n.translate(context, 'slide_show.slide_four.title'),
          description: FlutterI18n.translate(context, 'slide_show.slide_four.description'),
          pathImage: 'assets/pictures/tap.png',
          backgroundColor: Color(0XFF008A73),
        ),

        Slide(
          title: FlutterI18n.translate(context, 'slide_show.slide_three.title'),
          description: FlutterI18n.translate(context, 'slide_show.slide_three.description'),
          pathImage: 'assets/pictures/shield.png',
          backgroundColor: Color(0xff203152),
        ),
      ],
    );
  }
}