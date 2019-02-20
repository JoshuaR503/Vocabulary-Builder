// import 'package:flutter/material.dart';

// import './others/info-screen.dart';
// import './palabras-screen.dart';
// import '../model/main.dart';
// import '../utils/settings.dart';

// class HomeScreen extends StatefulWidget {

//   final MainModel model;

//   HomeScreen(this.model);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen>  {

//   @override
//     bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
    
//           title: Text(appname),
//           centerTitle: true,
//           elevation: 0.0,

//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.favorite_border),
//               onPressed: () => Navigator.pushNamed(context, '/saved')
//             )
//           ],
   
//           bottom: TabBar(
//             tabs: <Widget>[
//              Tab(text: "INICO"),
//              Tab(text: "INFORMACION"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//            PalabrasScreen(widget.model),
//            InfoScreen()
//           ],
//         ),
//       ),
//     );

//     // return Scaffold(
//     //   appBar: AppBar(
        
//     //     title: Text(appname),
//     //     centerTitle: true,
//     //     elevation: 0.0,

//     //     actions: <Widget>[
//     //       IconButton(
//     //         icon: Icon(Icons.favorite_border),
//     //         onPressed: () => Navigator.pushNamed(context, '/saved')
//     //       )
//     //     ],

        

//     //     bottom: TabBar(
//     //       controller: _tabController,
//     //       tabs: <Widget>[
//     //        Tab(text: "INICO"),
//     //        Tab(text: "INFORMACION"),
//     //       ],
//     //     ),
//     //   ),

//     //   body: 
      
//     //   TabBarView(
//     //     controller: _tabController,
//     //     children: <Widget>[
//     //      PalabrasScreen(widget.model),
//     //      InfoScreen()
//     //     //  PalabraGuardadaScreen(widget.model),
//     //     ],
//     //   ),
//     // );
//   }
// }