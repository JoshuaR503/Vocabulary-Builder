
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/screens/word/widgets/styles.dart';

class HelpScreen extends StatefulWidget {

  final Color color;

  HelpScreen({
    this.color
  }) : assert(color != null);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,

      child: Scaffold(
        backgroundColor: Color(0xFF1e1e1e),
        appBar: AppBar(
          backgroundColor: this.widget.color,
          title: Text('Help and Information'),
          centerTitle: true,
          bottom: TabBar(
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Questions'),
              Tab(text: 'Solutions'),
              Tab(text: 'Credits'),
            ]
          ),
        ),

        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text(
                'Question View',
                style: TextStyles.titleStyle,
              ),
            ),

            Center(
              child: Text(
                'Solutions View',
                style: TextStyles.titleStyle,
              ),
            ),

            Center(
              child: Text(
                'Credits View',
                style: TextStyles.titleStyle,
              ),
            ),

          ],
        )

      )
    );
  }
}