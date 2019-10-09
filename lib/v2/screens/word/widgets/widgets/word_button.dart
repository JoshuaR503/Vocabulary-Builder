import 'package:flutter/material.dart';

class WordCateogry extends StatelessWidget {

  final String category;

  WordCateogry({
    this.category,
  }) : assert(category != null);

  Widget _buildContainer({String text}) {
    final String cleanText = text.trim();
    final int length = cleanText.length;
    final double width = length < 8 
    ? length * 18.0 
    : length * 14.0;

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color:  Colors.black.withOpacity(0.5),
      ),
      height: 35.0,
      width: width,
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainers({int size, List categories}) {
    return ListView.builder(  
      scrollDirection: Axis.horizontal,
      itemCount: size,
      itemBuilder: (context, index) =>
        Container(
          padding: EdgeInsets.only(right: 15.0),
          child: _buildContainer(text: categories[index])
        )
    );
  }

  Widget _build() {
    final List categories = category.split(',');
    final int categoriesSzie = categories.length;
  
    return Container(
      height: 50.0,
      child: categoriesSzie > 1
      ? _buildContainers(size: categoriesSzie, categories: categories)
      : _buildContainer(text: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build();
  }
}