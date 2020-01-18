import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebasePushNotificationClient {

  final FirebaseMessaging _messaging = FirebaseMessaging();
  final StreamController<String> _messagingController = StreamController<String>.broadcast();

  Stream<String> get message => _messagingController.stream;

  void initNotifications() {
    // Request user permission.
    _messaging.requestNotificationPermissions();
    
    // Get Token.
    _messaging
      .getToken()
      .then((token) => print(token))
      .catchError((error) => print(error));

    // Handlers.
    _messaging.configure(
      onMessage: (info) async {
        _messagingController.sink.add('onMessage');
      },
      onLaunch: (info) async {
        _messagingController.sink.add('onLaunch');
      },
      onResume: (info) async {
        _messagingController.sink.add('onResume');
      }
    );
  }

  dispose() {
    _messagingController?.close();
  }
}