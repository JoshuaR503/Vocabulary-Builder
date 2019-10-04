
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';

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

  Widget _buildDataRow() {

    final ShapeBorder shape = RoundedRectangleBorder( borderRadius: BorderRadius.circular(10));

    final Column col1 = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,

      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 45, top: 20),
          child: MaterialButton(
            elevation: 2,
            color: word.color,
            shape: shape,
            child: Icon(
              Icons.volume_up,
              color: Colors.white,
            ), 
            onPressed: () {},
          )
        ),

        Padding(
          padding: EdgeInsets.only(left: 45, top: 10),
          child: MaterialButton(
            elevation: 2,
            color: word.color,
            shape: shape,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ), 
            onPressed: () {},
          )
        )
      ],
    );

    final Column col = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.only(left: 30.0, top: 20),
          child: Text(
            this.word.word,
            style: TextStyle(
              fontSize: 25.0, 
              fontWeight: FontWeight.bold
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: 30.0, top: 20),
          child: Text(
            this.word.wordTranslation,
            style: TextStyle(
              fontSize: 20.0, 
              fontWeight: FontWeight.w300
            ),
          ),
        ),

      ],
    );

    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Material(
        elevation: 20.0,
        shadowColor: Colors.black87,
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          children: <Widget>[
            Expanded(child: col, flex: 10),
            Expanded(child: col1, flex:5),
            Expanded(child: Container(width: 1.0))
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return  _buildDataRow();
  }
}
