import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:vocabulary_builder/v2/config/config.dart';
import 'package:vocabulary_builder/v2/repositories/notifications/notification_client.dart';

import 'package:vocabulary_builder/v2/screens/home/widgets/category_list.dart';
import 'package:vocabulary_builder/v2/screens/home/widgets/search.dart';
import 'package:vocabulary_builder/v2/widgets/components/reusable/container.dart';

class Home extends StatefulWidget {

  final bool shouldAdLoad;

  Home({
    @required this.shouldAdLoad
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  final FirebasePushNotificationClient _pushNotification = FirebasePushNotificationClient();
  
  final InterstitialAd _beautifulAd = InterstitialAd(
    adUnitId: kAdUnitId,
    targetingInfo: MobileAdTargetingInfo(
      keywords: kMobileAdTargetingKeyWords,
      childDirected: false,
    ),
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );

  @override
  void initState() {
    super.initState();

    _pushNotification.initNotifications();

    FirebaseAdMob.instance.initialize(appId: kPublishedId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildAppTitle() {
    return Text(
      FlutterI18n.translate(context, 'home.app_text'),
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  List<Widget> _buildContent() {
    return [
      VocabularyBuilderContainer(
        children: <Widget>[        
          SizedBox(height: 60),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: _buildAppTitle() 
          ),

          SizedBox(height: 40),
          VocabularyBuilderSearch(),

          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: CategoryList(),
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {

    if (this.widget.shouldAdLoad) {
      _beautifulAd
        ..load()
        ..show();
    }

    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    final bool isSmall = deviceWidth < 480 && deviceHeight < 200;
    final bool isBig = deviceWidth >= 500.0;
  
    final double smallWidth = deviceWidth / 30;
    final double bigWidth = deviceWidth / 8;
    
    final double horizontal = isSmall 
    ? smallWidth : isBig
    ? bigWidth : 0;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal ),
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
        child: ListView(
          children: _buildContent()
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () => Navigator
          .of(context)
          .pushNamed('/settings')
      )
    );
  }
}
