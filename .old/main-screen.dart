// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:flutter_web_browser/flutter_web_browser.dart';

// import '../widgets/palabra-guardada/palabra-guardada.dart';
// import '../widgets/palabras/palabras.dart';
// import '../utils/settings.dart';
// import '../model/main.dart';

// class MainScreen extends StatefulWidget {
  
//   final MainModel model;
  
//   MainScreen(this.model);

//   @override
//     State<StatefulWidget> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> with AutomaticKeepAliveClientMixin {

//   @override
//   bool get wantKeepAlive => false; 

//   @override
//   void initState() {
//     widget.model.obtenerPalabras();
//     widget.model.obtenerPalabrasGuardadas();
//     super.initState();
//   }

//   Widget _buildSideDrawer(BuildContext context) {
//     return Drawer(

//       child: ListView(
//         children: <Widget>[
//           AppBar(
//             automaticallyImplyLeading: false,
//             title: Text(appname),
//           ),
//           ListTile(
//             leading: Icon(Icons.bookmark_border),
//             title: Text(savedSection),
//             onTap: () => Navigator.pushNamed(context, '/saved')
//           ),         
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.info),
//             title: Text(infoSection),
//             onTap: () => Navigator.pushNamed(context, '/about')
//           ),

//           Divider(),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text(infoSection),
//             onTap: () => Navigator.pushNamed(context, '/settings')
//           ),
          
//           ListTile(
//             leading: Icon(Icons.people),
//             title: Text('Comentarios'),
//             onTap: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback)
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMainContent() {
    
//     return ScopedModelDescendant(
//       builder: (BuildContext context, Widget child, MainModel model) {

//         Widget content = Center(child: Text(onServerConnection));

//         if (model.allPalabras.length > 0 && !model.isLoading) {
//           content = Palabras();
//         } else if (model.isLoading) {
//           content = Center(child: CircularProgressIndicator());
//         }

//         return RefreshIndicator(
//           onRefresh: model.obtenerPalabras,
//           child: content
//         );
//       }
//     );
//   }

//   Widget _buildSavedContent() {
//     return ScopedModelDescendant(
//       builder: (BuildContext context, Widget child, MainModel model) {

//         Widget content = Center(child: Text(onNoSavedWords));

//         if (model.allPalabrasGuardadas.length > 0 && !model.palabrasGuardadasIsLoading) {
//           content = PalabrasGuardadas();
//         } else if (model.palabrasGuardadasIsLoading) {
//           content = Center(child: CircularProgressIndicator());
//         }

//         return RefreshIndicator(
//           onRefresh: model.obtenerPalabrasGuardadas,
//           child: content,
//         );
//       }
//     );
//   }

//   @override 
//   Widget build(BuildContext context) {

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         drawer:  _buildSideDrawer(context),
//         appBar: AppBar(
//           title: Text(appname),
//           centerTitle: true,

//           bottom: TabBar(
//             tabs: [
//               Tab(text: "SAVED"),
//               Tab(text: "HOME",),
              
//             ],
//           ),
//         ),

//         body: TabBarView(
//           children: <Widget>[
//             _buildSavedContent(),
//             _buildMainContent(),
//           ],
//         ),
//       ),
//     );
//   }
// }