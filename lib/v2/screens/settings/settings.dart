
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/widgets/text/index.dart';
import 'package:vocabulary_builder/v2/widgets/ui/index.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2b2b2b),
        title: Text('Settings Screen'),
        centerTitle: true,
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: SafeArea(
          child: ListView(
            children: <Widget>[

              CommonTitle('Change Language'),
              ListCell(
                title: 'You will be redirected to another screen where you can change the app\'s language',
                subtitle: 'Tap to change',
                onTap: () => Navigator.of(context).pushNamed('/language'),
              ),


              CommonTitle('Change Difficulty'),
              ListCell(
                title: 'You will be redirected to another screen where you can change the app\'s difficulty',
                subtitle: 'Tap to change',
                onTap: () => Navigator.of(context).pushNamed('/level'),
              ),
              
            ],
          )
        )
      ),
    );
  }
}