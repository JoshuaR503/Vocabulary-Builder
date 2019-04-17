import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:vocabulary_builder/model/main.dart';
import 'package:vocabulary_builder/widgets/ui/elements/slider.dart';

class IntroScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return IntroSlider(
          slides: [
            Slide(
              title: FlutterI18n.translate(context, 'slide_show.slide_one.title'),
              description: FlutterI18n.translate(context, 'slide_show.slide_one.description'),
              pathImage: 'assets/books.png',
              backgroundColor: Color(0xfff5a623),
            ),

            Slide(
              title: FlutterI18n.translate(context, 'slide_show.slide_two.title'),
              description: FlutterI18n.translate(context, 'slide_show.slide_two.description'),
              pathImage: 'assets/idea.png',
              backgroundColor: Color(0XFFC41E3D),
            ),

            Slide(
              title: FlutterI18n.translate(context, 'slide_show.slide_three.title'),
              description: FlutterI18n.translate(context, 'slide_show.slide_three.description'),
              pathImage: 'assets/shield.png',
              backgroundColor: Color(0xff203152),
            ),

            // Slide(
            //   title: FlutterI18n.translate(context, 'slide_show.slide_four.title'),
            //   description: FlutterI18n.translate(context, 'slide_show.slide_four.description'),
            //   pathImage: 'assets/tap.png',
            //   backgroundColor: Color(0XFF008A73),
            // ),
          ],
          onDonePress: () => model.setData().then((_) => Navigator.pushReplacementNamed(context, '/home')),
          onSkipPress: () => model.setData().then((_) => Navigator.pushReplacementNamed(context, '/home')),
        );
      }
    );
  }
}