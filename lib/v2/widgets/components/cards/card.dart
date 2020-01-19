import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/screens/word/word.dart';
import 'package:vocabulary_builder/v2/widgets/text/index.dart';

class VocabularyBuilderCard extends StatefulWidget {
  const VocabularyBuilderCard({
    @required this.word,
    @required this.topIcon,
    @required this.bottomIcon,
    @required this.onPressed,
  }) : assert(word != null),
       assert(topIcon != null),
       assert(bottomIcon != null),
       assert(onPressed != null);

  final Word word;
  
  final Widget topIcon;
  final Widget bottomIcon;

  final Function onPressed;

  @override
  _VocabularyBuilderCardState createState() => _VocabularyBuilderCardState();
}

class _VocabularyBuilderCardState extends State<VocabularyBuilderCard> {
  
  void _changeScreen() async {
    Navigator
    .of(context)
    .push(MaterialPageRoute(
      builder: (context) => WordScreen(word: this.widget.word)
    ));
  }

  Widget _buildMaterialButton({Widget child, Function onPressed}) {
    
    final ShapeBorder shape = RoundedRectangleBorder( borderRadius: BorderRadius.circular(10));    
    final Color color = widget.word.shouldHaveColor 
    ? widget.word.color // Color from Word.
    : widget.word.forcedColor; // Default color.

    return MaterialButton(
      minWidth: 2,
      elevation: 2,
      color: color,
      shape: shape,
      onPressed: onPressed,
      child: child
    );
  }

  List<Widget> _buildRigthColumn() {
    return [
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: _buildMaterialButton(
          onPressed: this.widget.onPressed,
          child: this.widget.topIcon,
        )
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: _buildMaterialButton(
          onPressed: _changeScreen,
          child: this.widget.bottomIcon
        )
      )
    ];
  }

  List<Widget> _buildLeftColumn(bool isSmall) {
    return [
      GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => WordScreen(word: this.widget.word)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 20),
              child: Text(
                this.widget.word.targetLanguage.word,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyles.titleStyle
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 10),
              child: Text(
                this.widget.word.firstLanguage.word,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.normal,
                )
              ),
            ),
          ],
        ),
      )
    ];
  }

  Widget _buildCard(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isSmall = size.width <= 479;

    final Column leftColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildLeftColumn(isSmall)
    );
    
    final Column rightColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _buildRigthColumn()
    );

    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          children: <Widget>[
            Expanded(child: leftColumn, flex: 10),
            Expanded(child: rightColumn, flex: 5),
            Expanded(child: Container(width: 1.0))
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard(context);
  }
}
