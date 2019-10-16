
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/widgets/text/styles.dart';

class SearchScreen extends StatefulWidget {

  SearchScreen({
    @required this.search
  }) : assert(search != null);

  final String search;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2b2b2b),
        title: Text('Search Screen'),
        centerTitle: true,
      ),
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: SafeArea(
          child: Center(
            child: Text(
              widget.search,
              style: TextStyles.titleStyle,
            ),
          )
        )
      ),
    );
  }
}