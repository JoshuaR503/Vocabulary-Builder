
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/screens/help/widgets/credits.dart';
import 'package:vocabulary_builder/v2/screens/help/widgets/questions.dart';
import 'package:vocabulary_builder/v2/screens/help/widgets/solutions.dart';

class HelpScreen extends StatefulWidget {

  final Color color;

  HelpScreen({
    this.color
  }) : assert(color != null);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  Widget _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildTabBarView() {
    return SafeArea(
      child: TabBarView(
        children: <Widget>[
          QuestionsTab(),
          SolutionsTab(),
          CreditsTab(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFF1e1e1e),
        appBar: _buildAppBar(),
        body: _buildTabBarView()
      )
    );
  }
}