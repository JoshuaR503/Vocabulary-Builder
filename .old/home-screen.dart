// import 'package:flutter/material.dart';
// import 'package:flutter_web_browser/flutter_web_browser.dart';

// import '../widgets/ui/gradient-card.dart';
// import '../utils/settings.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
      
//       appBar: AppBar( 
//         title: Text(appname),
//         centerTitle: true,
//       ),

//       body: SafeArea(
//         child: ListView(
//           children: <Widget>[

//             Padding(
//               padding: EdgeInsets.only(left: 16, top: 24, bottom: 24),
//               child: Text(
//                 "Learning Center",
//                 style: TextStyle(
//                   fontSize: 26.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white
//                 ),
//               ),
//             ),

//             GradientCard(
//               function: () => Navigator.pushNamed(context, '/palabras'),
//               tag: 'title1',
//               title: 'Aprender Nuevas Palabras',
//               firstColor: 0xFF00C6FF,
//               secondColor: 0xFF0072FF,
//             ),

//             GradientCard(
//               function: () => Navigator.pushNamed(context, '/saved'),
//               tag: 'title3',
//               title: 'Palabras Guardadas',
//               firstColor: 0xFFF85032,
//               secondColor: 0xFFE73827,
//             ),

//             GradientCard(
//               function: () => FlutterWebBrowser.openWebPage(url: urlSendFeedback),
//               tag: 'title4',
//               title: 'Enviar comentarios',
//               firstColor: 0xFFFF512F,
//               secondColor: 0xFFF83600,
//             ),

//             // GradientCard(
//             //   function: () => Navigator.pushNamed(context, '/about'),
//             //   tag: 'title2',
//             //   title: 'Creditos',
//             //   firstColor: 0xFFAA076B,
//             //   secondColor: 0xFFDD2476,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }