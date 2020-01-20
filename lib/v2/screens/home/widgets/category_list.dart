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

  void _pushCategory({String route, String name, String categoryName, Color color, Color accentColor}) {

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

  void _pushSpecial({String category}) {
    Navigator
    .of(context)
    .pushNamed(category);
  }
  
  void _loadSavedWords() {
    BlocProvider
    .of<WordBloc>(context)
    .add(FetchWordsEvent());
  }

  void _onPressedHandler(int index) {
    
    final List<WordCategory> categories = this._fetchCategories();
    final String categoryName = categories[index].categoryName;
    final Color categoryColor = categories[index].color;
    final Color categoryAccentColor = categories[index].accentColor;
        final String name = categories[index].name;

    if (categories[index].isSpecial) {

      this._pushSpecial(category: categoryName);

      if (categoryName == '/saved') this._loadSavedWords();
    
    } else {
      this._pushCategory(
        accentColor: categoryAccentColor,
        categoryName: categoryName,
        color: categoryColor,
        name: name,
      );
    }
  }
  
  List<WordCategory> _fetchCategories() {
    return [
      WordCategory(
        accentColor: AppColors.kGreenLight,
        categoryName: 'latest',
        color: AppColors.kGreenLightAccent,
        name: FlutterI18n.translate(context, 'home.category.latest'),
      ),

      WordCategory(
        accentColor: AppColors.red,
        categoryName: 'verbose',
        color: AppColors.red,
        name: FlutterI18n.translate(context, 'home.category.verb'),
      ),

      WordCategory(
        accentColor: AppColors.blue,
        categoryName: 'adjectives',
        color: AppColors.blue,
        name: FlutterI18n.translate(context, 'home.category.adjectives'),
      ),

      WordCategory(
        accentColor: AppColors.orange,
        categoryName: 'adverbs',
        color: AppColors.orange,
        name: FlutterI18n.translate(context, 'home.category.adverbs'),
      ),

      WordCategory(
        accentColor: AppColors.indigo,
        categoryName: "/saved",
        color: AppColors.indigo,
        name: FlutterI18n.translate(context, 'home.category.saved'),

        isSpecial: true
      ),

      WordCategory(
        accentColor: AppColors.amberAccent,
        categoryName: 'nouns',
        color: AppColors.amber,
        name: FlutterI18n.translate(context, 'home.category.nouns'),
      ),

      WordCategory(
        accentColor: AppColors.purple,
        categoryName: 'random',
        color: AppColors.purple,
        name: FlutterI18n.translate(context, 'home.category.all_words'),
      ),

      WordCategory(
        accentColor: AppColors.brown,
        categoryName: 'idioms',
        color: AppColors.brown,
        name: FlutterI18n.translate(context, 'home.category.idioms'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    final List<WordCategory> categories = this._fetchCategories();
    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;

    return GridView.builder(
      padding: EdgeInsets.only(bottom: 58),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
  
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,

        childAspectRatio: isSmall 
          ? deviceWidth / 150
          : deviceWidth / 180,
      ),
  
      itemCount: categories.length,
      itemBuilder: (context, index) => 
      
      CategoryCard(
        categories[index],
        onPress: () => this._onPressedHandler(index)
      ),
    );
  }
}
