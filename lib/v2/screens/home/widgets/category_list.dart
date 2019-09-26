import 'package:flutter/cupertino.dart';
import 'package:vocabulary_builder/v2/data/categories.dart';
import 'package:vocabulary_builder/v2/screens/home/widgets/category_card.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final double deviceWidth = MediaQuery.of(context).size.width;
    final bool isSmall = deviceWidth <= 479;
    final double space = isSmall 
    ? deviceWidth / 150
    : deviceWidth / 200;

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: space,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
      ),
      padding: EdgeInsets.only(bottom: 58),
      itemCount: categories.length,
      itemBuilder: (context, index) => CategoryCard(
        categories[index],
      ),
    );
  }
}
