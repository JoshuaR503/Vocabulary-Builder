
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/screens/help/help.dart';
import 'package:vocabulary_builder/v2/widgets/text/index.dart';
import 'package:vocabulary_builder/v2/widgets/ui/container.dart';
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
          child: SimpleContainer(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[

                CommonTitle('Change Learning Language'),
                ListCell(
                  title: 'You can always change this setting here. Just tap English or Spanish.',
                  subtitle: 'Change language',
                  onTap: () => Navigator.of(context).pushNamed('/language'),

                ),

                CommonTitle("Change Experience Level"),
                ListCell(
                  title: 'Is it too hard or maybe too easy?\nDoesn\'t matter. Just tap to change it.',
                  subtitle: 'Change Experience level',
                  onTap: () => Navigator.of(context).pushNamed('/level'),
                ),
              ],
            ),
          )
        )
      ),

      floatingActionButton: FloatingActionButton(
          child: Text('🤔', style: TextStyle(fontSize: 35)),
          onPressed: () =>
            Navigator
              .of(context)
              .push(MaterialPageRoute(
                builder: (context) => HelpScreen(color: AppColors.red, initialIndex: 2)
              )),
        ),
    );
  }
}