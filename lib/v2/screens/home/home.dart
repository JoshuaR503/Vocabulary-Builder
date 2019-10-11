import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabulary_builder/v2/blocs/theme/bloc.dart';

import 'package:vocabulary_builder/v2/config/config.dart';
import 'package:vocabulary_builder/v2/widgets/components/container.dart';

import 'package:vocabulary_builder/v2/screens/home/widgets/search.dart';
import 'package:vocabulary_builder/v2/screens/home/widgets/category_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _changeTheme() async {

    final sp = await SharedPreferences.getInstance();
    final currentTheme = sp.getString('app_theme') ?? false;
    final bool isLight = currentTheme == 'Light';
    final String theme = isLight 
    ? 'Dark' 
    : 'Light';

    BlocProvider
      .of<ThemeBloc>(context)
      .dispatch(ThemeChanged(theme: theme));
  }

  Widget _buildAppTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        appName,
        style: TextStyle(
          fontSize: 32,
          height: 0.6,
          fontWeight: FontWeight.w900,
        ),
      )
    );
  }

  Widget _buildContent() {
    return VocabularyBuilderContainer(
      children: <Widget>[        
        SizedBox(height: 80),
        _buildAppTitle(),

        SizedBox(height: 40),
        VocabularyBuilderSearch(),

        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: CategoryList()
        )
      ],
    );
  }

  Widget _buildButton() {
    return FloatingActionButton(
      child: Icon(Icons.settings),
      onPressed: _changeTheme
    );
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    final bool isSmall = deviceWidth < 480 && deviceHeight < 200;
    final bool isBig = deviceWidth >= 890.0;
  
    final double smallWidth = deviceWidth / 30;
    final double bigWidth = deviceWidth / 10;
    final double horizontal = isSmall 
    ? smallWidth : isBig 
    ? bigWidth : 0;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal),
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: ListView(
          children: <Widget>[
            _buildContent()
          ],
        )
      ),
      floatingActionButton: _buildButton()
    );
  }
}
