import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/repositories/settings/settings_repository.dart';
import 'package:vocabulary_builder/v2/screens/home/home.dart';
import 'package:vocabulary_builder/v2/screens/language/widgets/title.dart';
import 'package:vocabulary_builder/v2/widgets/components/button.dart';

class VerticalLayout extends StatelessWidget {

  void _onTap(String language, BuildContext context) {

    final SettingsRepository settingsRepository = SettingsRepository();

    settingsRepository.setUserLanguage(language: language);

    Navigator
    .of(context)
    .push(MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 650.0 : deviceWidth;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ListView(

        children: <Widget>[

          LanguageTitle(),
          
          SizedBox(height: targetWidth / 10),
  
          Container(
            padding: EdgeInsets.symmetric(vertical: targetWidth / 50),
            child: Button('English', () => _onTap('en', context), targetWidth),
          ),
  
          Container(
            padding: EdgeInsets.symmetric(vertical: targetWidth / 50),
            child: Button('Spanish', () => _onTap('es', context), targetWidth),
          )
        ],
      ),
    );
  }
}