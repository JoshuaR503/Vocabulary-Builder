// import 'package:flutter/material.dart';

// import '../../widgets/palabra/single-palabra-card.dart';
// import '../../widgets/ui/cards/gradient-card.dart';
// import '../../widgets/ui/text/row-item.dart';
// import '../../widgets/ui/text/title.dart';
// import '../../widgets/ui/head-card.dart';
// import '../../widgets/ui/divider.dart';

// class InfoScreen extends StatefulWidget {

//   @override
//   State<StatefulWidget> createState() =>_InfoScreenState();
// }

// class _InfoScreenState extends State<InfoScreen> {

//   @override
//     Widget build(BuildContext context) {
//       return ListView(

//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.all(6.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 CommonTitle('Learning Center'),
//                 Separator.spacer(height: 12.0),

                
//                 GradientCard(
//                   function: () => Navigator.pushNamed(context, '/palabras'),
//                   tag: 'title1',
//                   title: 'What is a verb?',
//                   firstColor: 0xFF00C6FF,
//                   secondColor: 0xFF0072FF,
//                 ),

//                 GradientCard(
//                   function: () => Navigator.pushNamed(context, '/palabras'),
//                   tag: 'title1',
//                   title: 'What is a noun?',
//                   firstColor: 0xFF00C6FF,
//                   secondColor: 0xFF0072FF,
//                 ),

//                 GradientCard(
//                   function: () => Navigator.pushNamed(context, '/palabras'),
//                   tag: 'title1',
//                   title: 'What is an adjective?',
//                   firstColor: 0xFF00C6FF,
//                   secondColor: 0xFF0072FF,
//                 ),
              

//               ],
//             ),
//           ),
//         ],
//       );
//     }
// }