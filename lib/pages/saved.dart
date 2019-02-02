import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../model/palabra_guardada.model.dart';
import '../utils/db.helper.dart';
import '../utils/settings.dart';

import 'dart:async';

class SavedScreen extends StatefulWidget {
  @override
    State<StatefulWidget> createState() => _SavedScreenStatus();
}

class _SavedScreenStatus extends State<SavedScreen> with TickerProviderStateMixin {

  DatabaseHelper databaseHelper = DatabaseHelper();
  FlutterTts flutterTts = new FlutterTts();
  AnimationController _controller;
  Animation<double> _animation;

  List<PalabraGuardada> dataList;
  bool _isLoading = true;
	int count = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (dataList == null) {
			dataList = List<PalabraGuardada>();
			_updateListView();
		}

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(savedSection),
          centerTitle: true,
        ),
        body: _buildMainContent()
      )
    );
  }

  Widget _buildMainContent() {

    Widget content = Center(child: CircularProgressIndicator());
    
    if (dataList.length > 0 && !_isLoading) {
      content = _builListView();
    } else if (_isLoading) {
      content = Center(child: CircularProgressIndicator());
    } else {
      content = Container(child: Center(child: Text(onNoSavedWords)));
    }

    return content;
  }

  Widget _buildCircleAvatar(bool eliminar) {

    Widget circleAvatar = Container();
    final color = Colors.white;

    if (eliminar) {
      circleAvatar = CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(Icons.delete, color: color),
      );
    } else {
      circleAvatar = CircleAvatar(
				backgroundColor: Colors.amber,
				child: Icon(Icons.volume_up, color: color)
			);
    }

    return circleAvatar;
  }

  ListView _builListView() {

		TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    
		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int index) {
				return FadeTransition(
          opacity: _animation,
          child: Card(
				  	elevation: 2.0,
				  	child: ListTile(
              
				  		leading: _buildCircleAvatar(false),
              trailing: GestureDetector (
                child: _buildCircleAvatar(true),
				  		  onTap: () => _deleteData(context, dataList[index]),
				  	  ),

				  		title: Text(this.dataList[index].palabra, style: titleStyle,),
				  		subtitle: Text(this.dataList[index].traduccion),
              onTap: () => _speak(this.dataList[index].palabra)
				  	),
				  ),
        );
			},
		);
  }

  void _updateListView() {

    setState(() => _isLoading = true);

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<PalabraGuardada>> dataListFuture = databaseHelper.fetchSavedDataList();

			dataListFuture
      .then((dataList) {
				setState(() {
				  this.dataList = dataList;
				  this.count = dataList.length;
          _isLoading = false;
				});
			})
      .catchError((error) => setState(() => _isLoading = false));
		});
  }

  void _deleteData(BuildContext context, PalabraGuardada palabra) async {
    int result = await databaseHelper.deletePalabra(palabra.id);
		if (result != 0) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(onSuccessDeletingWord)));
			_updateListView();
		} else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(onErrorDeletingMessage)));
    }
  }

  void _speak(String text) { 
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.8);
    flutterTts.speak(text);
  }
}