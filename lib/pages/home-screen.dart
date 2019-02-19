import 'package:flutter/material.dart';

import './palabras-screen.dart';
import './palabra-guardada-screen.dart';
import '../model/main.dart';
import '../utils/settings.dart';

class HomeScreen extends StatefulWidget {

  final MainModel model;

  HomeScreen(this.model);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen>, TickerProviderStateMixin {

  TabController _tabController;

  @override
    bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appname),
        centerTitle: true,
        elevation: 0.0,
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
           Tab(text: "INICO"),
           Tab(text: "FAVORITO"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
         PalabrasScreen(widget.model),
         PalabraGuardadaScreen(widget.model),
        ],
      ),
    );
  }
}