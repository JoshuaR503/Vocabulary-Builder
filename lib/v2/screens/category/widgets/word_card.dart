
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/word.dart';

class WordCard extends StatelessWidget {
  WordCard(
    this.word, 
    {
      @required this.index,
      Key key,
      this.onPress,
    }
  ) : super(key: key);

  final int index;
  final Function onPress;
  final Word word;

  Widget _buildCardContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: Text(
                word.word,
                style: TextStyle(
                  fontSize: 16,
                  height: 0.7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // boxShadow: [
            //   BoxShadow(
            //     // color: pokemon.color.withOpacity(0.12),
            //     blurRadius: 1,
            //     offset: Offset(0, 1),
            //   ),
            // ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: word.color,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildCardContent(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
