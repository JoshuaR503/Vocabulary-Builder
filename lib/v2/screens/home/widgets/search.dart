import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_builder/v2/blocs/search/bloc.dart';
import 'package:vocabulary_builder/v2/screens/search/search.dart';

class VocabularyBuilderSearch extends StatefulWidget {
  const VocabularyBuilderSearch({
    Key key,
    this.margin = const EdgeInsets.symmetric(horizontal: 28),
  }) : super(key: key);

  final EdgeInsets margin;

  @override
  _VocabularyBuilderSearchState createState() => _VocabularyBuilderSearchState();
}

class _VocabularyBuilderSearchState extends State<VocabularyBuilderSearch> {

  Widget _buildTextFormField(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Search nouns, verbs, adjectives, etc...",
        hintStyle: TextStyle(
          fontSize: 16,
        ),
        border: InputBorder.none,
      ),

      onFieldSubmitted: (value) {
        BlocProvider
          .of<SearchBloc>(context)
          .dispatch(SearchWordsEvent(query: value));

        Navigator
          .of(context)
          .push(MaterialPageRoute(
            builder: (context) => SearchScreen(search: value)
          ));
      }
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    return [
      Icon(Icons.search),
      SizedBox(width: 13),
      Expanded(child: _buildTextFormField(context)),
    ];
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _buildChildren(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      margin: widget.margin,

      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),

      child: _buildRow(context),
    );
  }
}
