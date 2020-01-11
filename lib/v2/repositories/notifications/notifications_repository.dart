

import 'package:vocabulary_builder/v2/repositories/notifications/notification_client.dart';

class PushNotificationRepository {

  // Firebase Push Notification Repository.
  final FirebasePushNotificationClient _client = FirebasePushNotificationClient();

  // Initialize Notifications.
  void initNotifications() {
    _client.initNotifications();
  }

}
