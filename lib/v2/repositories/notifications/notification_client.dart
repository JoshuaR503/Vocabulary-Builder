

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebasePushNotificationClient {

  final FirebaseMessaging _messaging = FirebaseMessaging();

  void initNotifications() {
    _messaging.requestNotificationPermissions();
    
    _messaging
      .getToken()
      .then((token) => print(token))
      .catchError((error) => print(error));

    _messaging.configure(

      onMessage: (info) async {
        print('onMessage $info');
      },

      onLaunch: (info) async {
        print('onLaunch $info');
      },

      onResume: (info) async {
        print('onResume $info');
      }
    );
  }

}