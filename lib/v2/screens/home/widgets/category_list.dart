import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';
import 'package:vocabulary_builder/v2/config/categories.dart';
import 'package:vocabulary_builder/v2/screens/category/category.dart';

import 'package:vocabulary_builder/v2/screens/home/widgets/category_card.dart';

class CategoryList extends StatefulWidget {

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  void _changeRoute({
    String name,
    Color color
  }) {

    BlocProvider
      .of<WordsBloc>(context)
      .dispatch(FetchWords(category: name));

    Navigator
      .of(context)
      .push(MaterialPageRoute(
        builder: (context) => Category(
          title: name,
          color: color,
        )
      ));
  }

  GridView _buildGridView(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;
    final double space = isSmall 
    ? deviceWidth / 150
    : deviceWidth / 230;

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

          final String categoryName = categories[index].name;
          final Color categoryColor = categories[index].color;

          _changeRoute(
            name: categoryName,
            color: categoryColor
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGridView(context);
  }
}
