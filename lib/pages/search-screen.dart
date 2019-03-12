// import 'package:flutter/material.dart';

// import 'package:moblie/model/main.dart';
// import 'package:moblie/model/palabra.model.dart';

// import 'package:moblie/utils/settings.dart';
// import 'package:moblie/widgets/ui/elements/slim-card.dart';

// class PalabraSearch extends SearchDelegate<String> {

//   final MainModel _model = MainModel();

//   List palabrasSearch;

//   void obtenerPalabras() async {
//     String cleanQuery = query.toLowerCase();

//     await _model.obtenerPalabras(
//       search: true,
//       url: searchUrl + cleanQuery
//     );

//     palabrasSearch = _model.allPalabras;
//   }

//   final recentSearch = [
//     "October",
//     "November",
//     "December",
//     "March",
//     "April",
//   ];

//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     assert(context != null);
//     final ThemeData theme = Theme.of(context);
//     assert(theme != null);
//     return theme;
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // buildActions
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () => query = '',
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // buildLeading
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),

//       onPressed: () => close(context, null),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {


    
//     // buildResults
//     return _buildPalabrasList(_model.allPalabras, _model);
//   }
  
//   @override
//   Widget buildSuggestions(BuildContext context) {

//     obtenerPalabras();

//     // buildSuggestions
//     List suggestionList = palabrasSearch;

//     if (query.isEmpty) {
//       suggestionList = recentSearch;
//     }

//     final double fontSize = 18.0;

//     return ListView.builder(
//       itemCount: suggestionList.length,
//       itemBuilder: (context, index) =>
//         ListTile(
//           onTap: () => showResults(context),
//           title: RichText(
//             text: TextSpan(
//               text: suggestionList[index].substring(0, query.length),
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: fontSize
//               ),
//               children: [
//                 TextSpan(
//                   text: suggestionList[index].substring(query.length),
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: fontSize
//                   )
//                 )
//               ]
//             ),
//           ),
//         ) ,
//     );
//   }

//   Widget _buildPalabrasList(List<Palabra> palabras, MainModel model) {

//     Widget content;

//     if (palabras.length > 0) {
//       content = ListView.builder(
//         itemCount: palabras.length,
//         itemBuilder: (BuildContext context, int index) {

//           print(palabras[index]);

//           content = Container(child: Text('Data found!!!!'),);

//           // return SlimCard(
//           //   title: palabras[index].palabra,
//           //   subtitle: palabras[index].traduccion,

//           //   firstAvatar: CircleAvatar(
// 		      //   	backgroundColor: Colors.amber,
// 		      //   	child: Icon(Icons.volume_up, color: Colors.white),
// 		      //   ),

//           //   secondtAvatar: CircleAvatar(
//           //     backgroundColor: Colors.red,
//           //     child: Icon(Icons.info_outline, color: Colors.white),
//           //   ),

//           //   firstFunction: () {
//           //     model.speak(palabras[index].palabra);
//           //   },

//           //   palabra: palabras[index],
//           //   model: model,
//           // );
//         }
//       );
//     } else {
//       content = Container(child: Text('No data found'));
//     }

//     return content;
//   }
//  }

import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

searchPalabras(BuildContext context, List list) {
  return MaterialPageRoute (
    builder: (context) => Material(

      child: MaterialSearch(

        barBackgroundColor: Theme.of(context).primaryColor,
        iconColor: Colors.white,
        placeholder: 'Buscar',

        limit: list.length,
        results: list
          .map((palabra) => MaterialSearchResult(
            icon: Icons.search,
            value: palabra,
            text: palabra.palabra,
          ))
          .toList(),
        filter: (dynamic value, String criteria) => value.palabra
          .toLowerCase()
          .trim()
          .contains(RegExp(r'' + criteria.toLowerCase().trim() + '')),

        onSelect: (_) { print('xd'); } 
      ),
    )
  );
}