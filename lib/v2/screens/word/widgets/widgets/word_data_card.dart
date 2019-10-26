import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/widgets/text/index.dart';

class WordCard extends StatelessWidget {

  final String word;
  final String definition;

  WordCard({
    @required this.word,
    @required this.definition
  }) : assert(word != null),
       assert(definition != null);

  String _cleanString({String text}) {
    return text.trim();
  }

  List<Widget> _buildVolumeIcon() {
    final ShapeBorder shape = RoundedRectangleBorder( 
      borderRadius: BorderRadius.circular(10)
    );

    return [
      MaterialButton(
        minWidth: 2,
        elevation: 2,
        color: AppCardColors.backgroundColor,
        shape: shape,
        onPressed: () {},
        child: Icon(Icons.volume_up)
      ),
    ];
  }

  List<Widget> _buildTitle(bool isSmall) {
    final String text = this._cleanString(text: this.word);

    return [
      Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyles.titleStyle
      ),
    ];
  }

  Widget _buildDefinition() {
    final String text = this._cleanString(text: this.definition);
    
    return Text(
      text,
      style: TextStyles.definitionStyle
    );
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final bool isSmall = size.width <= 479;

    final Widget definition = _buildDefinition();
    final Column leftColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildTitle(isSmall)
    );

    final Column rightColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _buildVolumeIcon()
    );

    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Row(
                children: <Widget>[
                  Expanded(child: leftColumn, flex: 10),
                  Expanded(child: rightColumn, flex: 5),
                  Expanded(child: Container(width: 2.0)),
                ],
              ),
        
            ),

            SizedBox(height: 5),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: definition,
            ),

            SizedBox(height: 25),
          ],
        )
      )
    );
  }
}

