import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:vocabulary_builder/pages/others/creditos-screen.dart';
import 'package:vocabulary_builder/pages/others/help-screen.dart';
import 'package:vocabulary_builder/pages/others/question-screen.dart';

class Help extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 850.0 : deviceWidth;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(FlutterI18n.translate(context, 'help')),
          
          bottom: TabBar(
            tabs: [
              Tab(text: FlutterI18n.translate(context, 'question_answers.title')),
              Tab(text: FlutterI18n.translate(context, 'troubleshooting.title')),
              Tab(text: FlutterI18n.translate(context, 'credits.title')),
            ],
          ),

          centerTitle: true,
        ),

        body: TabBarView(
          children: [
            Center(
              child: Container(
                width: targetWidth,
                child: QuestionScreen(),
              )
            ),

            Center(
              child: Container(
                width: targetWidth,
                child: HelpScreen(),
              )
            ),

            Center(
              child: Container(
                width: targetWidth,
                child: CreditoScreen(),
              )
            ),
          ],
        ),
      ),
    );
  }
}