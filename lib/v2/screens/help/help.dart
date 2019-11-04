
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/v2/screens/help/widgets/credits.dart';
import 'package:vocabulary_builder/v2/screens/help/widgets/questions.dart';
import 'package:vocabulary_builder/v2/screens/help/widgets/solutions.dart';

class HelpScreen extends StatefulWidget {

  final Color color;
  final int initialIndex;

  HelpScreen({
    this.color,
    this.initialIndex = 0
  }) : assert(color != null);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: this.widget.color,
      title: Text(FlutterI18n.translate(context, 'help.section_title')),
      bottom: TabBar(
        indicatorWeight: 3,
        tabs: [
          Tab(text: FlutterI18n.translate(context, 'help.tabs.questions')),
          Tab(text: FlutterI18n.translate(context, 'help.tabs.help')),
          Tab(text: FlutterI18n.translate(context, 'help.tabs.credits')),
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
      initialIndex: widget.initialIndex,
      child: Scaffold(
        backgroundColor: Color(0xFF1e1e1e),
        appBar: _buildAppBar(),
        body: _buildTabBarView()
      )
    );
  }
}