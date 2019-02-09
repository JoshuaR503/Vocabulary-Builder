// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// import '../model/palabra_guardada.model.dart';
// import '../pages/palabra-single-screen.dart';
// import '../model/palabra.model.dart';
// import '../utils/db.helper.dart';
// import '../utils/settings.dart';

// import 'dart:async';

// class PalabrasSavedScreen extends StatefulWidget {
//   @override
//     State<StatefulWidget> createState() => _PalabrasSavedScreenStatus();
// }

// class _PalabrasSavedScreenStatus extends State<PalabrasSavedScreen> {

//   DatabaseHelper databaseHelper = DatabaseHelper();
//   FlutterTts flutterTts = new FlutterTts();

//   List<PalabraGuardada> dataList;
//   bool _isLoading = true;
// 	int count = 0;

//   @override
//   Widget build(BuildContext context) {

//     if (dataList == null) {
// 			dataList = List<PalabraGuardada>();
// 			_updateListView();
// 		}

//     return WillPopScope(
//       onWillPop: () {
//         Navigator.pop(context, false);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(savedSection),
//           centerTitle: true,
//         ),
//         body: _buildMainContent()
//       )
//     );
//   }

//   Widget _buildMainContent() {

//     Widget content = Center(child: CircularProgressIndicator());
    
//     if (dataList.length > 0 && !_isLoading) {
//       content = _builListView();
//     } else if (_isLoading) {
//       content = Center(child: CircularProgressIndicator());
//     } else {
//       content = Container(child: Center(child: Text(onNoSavedWords)));
//     }

//     return content;
//   }

//   Widget stackBehindDismiss() {
//     return Container(
//       alignment: Alignment.centerRight,
//       padding: EdgeInsets.only(right: 20.0),
//       color: Colors.red,
//       child: Icon(
//         Icons.delete,
//         color: Colors.white,
//       ),
//     );
//   }

//   ListView _builListView() {

// 		TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    
// 		return ListView.builder(
// 			itemCount: count,
// 			itemBuilder: (BuildContext context, int index) {

//         final Palabra singlePalabra =  Palabra(
//           palabra: dataList[index].palabra,
//           traduccion: dataList[index].traduccion,
//           definicion: dataList[index].definicion,
//           definicionEs: dataList[index].definicionEs,
//           sinonimos: dataList[index].sinonimos,
//           antonimos: dataList[index].antonimos,
//           ejemplos: dataList[index].ejemplos,
//           alt: false,
//           tipo: dataList[index].tipo,
//         );

//         return Dismissible(
//           key: ObjectKey(dataList[index]),
//           background: stackBehindDismiss(),
          
//           onDismissed: (direction) => _deleteData(context, dataList[index]),
  
//           child: GestureDetector(
            
//             child: Card(
// 				    	elevation: 2.0,
// 				    	child: ListTile(

// 				    		leading: CircleAvatar(
// 			          	backgroundColor: Colors.amber,
// 			          	child: Icon(Icons.volume_up, color: Colors.white),
                  
// 			          ),

//                 trailing: GestureDetector (
//                   child: CircleAvatar(
//                     backgroundColor: Colors.red,
//                     child: Icon(Icons.arrow_forward, color: Colors.white),
//                   ),
// 				    		  onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => SinglePalabraScreen(singlePalabra)),
//                   ),
// 				    	  ),

// 				    		title: Text(dataList[index].palabra, style: titleStyle,),
// 				    		subtitle: Text(dataList[index].traduccion),
//                 onTap: () => _speak(dataList[index].palabra)
// 				    	),

// 				    ),
//           )
//         );
// 			},
// 		);
//   }

//   void _updateListView() {

//     setState(() => _isLoading = true);

// 		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
// 		dbFuture.then((database) {

// 			Future<List<PalabraGuardada>> dataListFuture = databaseHelper.fetchSavedDataList();

// 			dataListFuture
//       .then((dataList) {
// 				setState(() {
// 				  this.dataList = dataList;
// 				  this.count = dataList.length;
//           _isLoading = false;
// 				});
// 			})
//       .catchError((error) => setState(() => _isLoading = false));
// 		});
//   }

//   void _deleteData(BuildContext context, PalabraGuardada palabra) async {
//     int result = await databaseHelper.deletePalabra(palabra.id);
// 		if (result != 0) {
//       Scaffold.of(context).showSnackBar(SnackBar(content: Text(onSuccessDeletingWord)));
// 			_updateListView();
// 		} else {
//       Scaffold.of(context).showSnackBar(SnackBar(content: Text(onErrorDeletingMessage)));
//     }
//   }

//   void _speak(String text) { 
//     flutterTts.setLanguage("en-US");
//     flutterTts.setPitch(1.0);
//     flutterTts.setSpeechRate(0.8);
//     flutterTts.speak(text);
//   }
// }