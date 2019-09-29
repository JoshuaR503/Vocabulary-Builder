import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/routes/bloc.dart';
import 'package:vocabulary_builder/v2/data/categories.dart';

import 'package:vocabulary_builder/v2/screens/home/widgets/category_card.dart';

class CategoryList extends StatefulWidget {

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  void _changeRoute(String route) {
    BlocProvider
      .of<RoutesBloc>(context)
      .dispatch(ChangeRoute(route: route));

    Navigator
      .of(context)
      .pushNamed('/nouns');
  }

  GridView _buildGridView(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;
    final double space = isSmall 
    ? deviceWidth / 150
    : deviceWidth / 200;

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
      itemBuilder: (context, index) => CategoryCard(
        categories[index],
        onPress: () {
          _changeRoute(categories[index].name);
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => RoutesBloc(),
      child: _buildGridView(context),
    );
  }
}
