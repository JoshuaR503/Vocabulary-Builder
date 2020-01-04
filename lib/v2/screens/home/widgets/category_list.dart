import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/blocs/word/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/words/bloc.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/category.dart';

import 'package:vocabulary_builder/v2/screens/category/category.dart';
import 'package:vocabulary_builder/v2/screens/home/widgets/category_card.dart';

class CategoryList extends StatefulWidget {

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  
  void _pushCategory({
    String route,
    String name,
    dynamic categoryName, 
    Color color, 
    Color accentColor }) {

    BlocProvider
      .of<WordsBloc>(context)
      .add(FetchWords(
        categoryName: categoryName,
        category: route
      ));

    Navigator
      .of(context)
      .push(MaterialPageRoute(
        builder: (context) => Category(
          categoryName: categoryName,
          route: route,
          title: name,
          color: color,
          accentColor: accentColor,
        )
      ));
  }

  void _loadFavortieWords() {
    BlocProvider
      .of<WordBloc>(context)
      .add(FetchWordsEvent());
  }
  
  void _pushSpecial({String category}) {
    Navigator
      .of(context)
      .pushNamed('/$category');
  }

  GridView _buildGridView() {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;
    final double space = isSmall 
    ? deviceWidth / 150
    : deviceWidth / 180;

    final List<WordCategory> categories = [
      WordCategory(
        name: FlutterI18n.translate(context, 'home.category.adverbs'),
        categoryName: 'adverbs',
        color: AppColors.tealAccent,
        accentColor: AppColors.tealAccent,
      ),

      WordCategory(
        name: FlutterI18n.translate(context, 'home.category.verb'),
        categoryName: 'verbose',
        color: AppColors.red,
        accentColor: AppColors.red,
      ),

      WordCategory(
        name: FlutterI18n.translate(context, 'home.category.adjectives'),
        categoryName: 'adjectives',
        color: AppColors.blue,
        accentColor: AppColors.blue
      ),

      WordCategory(
        name: 'Disabled',
        categoryName: null,
        color: AppColors.orange,
        accentColor: AppColors.orange,
      ),

      WordCategory(
        name: FlutterI18n.translate(context, 'home.category.saved'),
        categoryName: "saved",

        color: AppColors.indigo,
        accentColor: AppColors.indigo,
        isSpecial: true
      ),

      WordCategory(
        name: FlutterI18n.translate(context, 'home.category.nouns'),
        categoryName: 'nouns',

        color: AppColors.amber,
        accentColor: AppColors.amberAccent
      ),

      WordCategory(
        name: FlutterI18n.translate(context, 'home.category.all_words'),
        categoryName: "All Words",
        color: AppColors.purple,
        accentColor: AppColors.purple,
      ),

      WordCategory(
        name: FlutterI18n.translate(context, 'home.category.idioms'),
        categoryName: 'idioms',
        color: AppColors.brown,
        accentColor: AppColors.brown,
      ),
    ];

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
          final String name = categories[index].name;
          final String categoryName = categories[index].categoryName;
          final Color categoryColor = categories[index].color;
          final Color categoryAccentColor = categories[index].accentColor;

          if (categories[index].isSpecial) {

            _pushSpecial(category: categoryName);

            if (categoryName == 'saved') {
              _loadFavortieWords();
            }
            
          } else {
            _pushCategory(
              categoryName: categoryName,
              name: name,
              
              
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
    return _buildGridView();
  }
}
