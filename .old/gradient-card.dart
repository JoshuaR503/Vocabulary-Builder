// import 'package:flutter/material.dart';

// class GradientCard extends StatelessWidget {

//   final int firstColor;
//   final int secondColor;
//   final Function function;
//   final String tag;
//   final String title;

//   GradientCard({
//     @required this.firstColor,
//     @required this.secondColor,
//     @required this.function,
//     @required this.tag,
//     @required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Container(
//         child: InkWell(
          
//           onTap: () => function(),
  
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(16.0),

//                 child: Material(
//                   color: Colors.transparent,
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),

//         height: 90.0,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [  
//               Color(firstColor),
//               Color(secondColor),
//             ],
//             begin: Alignment.centerLeft, 
//             end: Alignment.centerRight,
//             tileMode: TileMode.clamp
//           ),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//     );
//   }
// }