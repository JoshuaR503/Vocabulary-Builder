import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';
import 'package:vocabulary_builder/v2/config/categories.dart';
import 'package:vocabulary_builder/v2/screens/category/category.dart';

import 'package:vocabulary_builder/v2/screens/home/widgets/category_card.dart';

class CategoryList extends StatefulWidget {

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  void _pushCategory({String route, String name, Color color, Color accentColor}) {
    BlocProvider
      .of<WordsBloc>(context)
      .add(FetchWords(category: route));

    Navigator
      .of(context)
      .push(MaterialPageRoute(
        builder: (context) => Category(
          route: route,
          title: name,
          color: color,
          accentColor: accentColor,
        )
      ));
  }

  void _addEvent() {
    BlocProvider
      .of<WordBloc>(context)
      .add(FetchWordsEvent());
  }
  
  void _pushSpecial({String route}) {
    Navigator
      .of(context)
      .pushNamed('/$route');
  }

  GridView _buildGridView(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;
    final double space = isSmall 
    ? deviceWidth / 150
    : deviceWidth / 180;

    return GridView.builder(
      padding: EdgeInsets.only(bottom: 58),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
  
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: space,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
      ),
  
      itemCount: categories.length,
      itemBuilder: (context, index) => 
      
      CategoryCard(
        categories[index],
        
        onPress: () {
          final String routeName = categories[index].routeName;
          final String categoryName = categories[index].name;
          final Color categoryColor = categories[index].color;
          final Color categoryAccentColor = categories[index].accentColor;

          if (categories[index].isSpecial) {
            _pushSpecial(route: routeName);

            if (categoryName == 'Favorite Words') _addEvent();
            
          } else {
            _pushCategory(
              name: categoryName,
              route: routeName,
              color: categoryColor,
              accentColor: categoryAccentColor
            );  
          }
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGridView(context);
  }
}
