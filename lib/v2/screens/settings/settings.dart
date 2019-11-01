
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

              CommonTitle('Change Learning Language'),
              ListCell(
                title: 'You can always change this setting here. Just tap English or Spanish.',
                subtitle: 'Change language',
                onTap: () => Navigator.of(context).pushNamed('/language'),
                leading: Image.asset(
                  'assets/pictures/translate.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),


              CommonTitle("Change Difficulty Level"),
              ListCell(
                title: 'Is it too hard or maybe too easy?\nYou can always change this setting\nat any time.',
                subtitle: 'Change difficulty level',
                onTap: () => Navigator.of(context).pushNamed('/level'),
                leading: Image.asset(
                  'assets/pictures/team-support.png',
                  height: 50.0,
                  width: 50.0,
                ),
              ),

              // CommonTitle('View Introduction'),
              // ListCell(
              //   title: 'You will be redirected to the introdcution screen',
              //   subtitle: 'Tap to view',
              //   onTap: () => Navigator.of(context).pushNamed('/into'),
              // ),
              
            ],
          )
        )
      ),
    );
  }
}