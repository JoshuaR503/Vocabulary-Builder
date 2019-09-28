import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vocabulary_builder/v2/config/config.dart';
import 'package:vocabulary_builder/v2/widgets/components/container.dart';

import 'package:vocabulary_builder/v2/screens/home/widgets/search.dart';
import 'package:vocabulary_builder/v2/screens/home/widgets/category_list.dart';

import 'package:vocabulary_builder/v2/themes/themes.dart';
import 'package:vocabulary_builder/v2/themes/bloc/bloc.dart';

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

  void _changeTheme() {
    BlocProvider
      .of<ThemeBloc>(context)
      .dispatch(ThemeChanged(theme: AppTheme.Dark));
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
      child: Icon(Icons.lightbulb_outline),
      onPressed: _changeTheme
    );
  }

  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;
    final double space = !isSmall 
    ? deviceWidth / 30
    : 0;
  
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: space),
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