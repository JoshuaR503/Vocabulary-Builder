


import 'package:vocabulary_builder/v2/repositories/notifications/notifications_repository.dart';

class PushNotificationClient {

  final FirebasePushNotificationRepository pushNotificationRepository = FirebasePushNotificationRepository();

  void initNotifications() {

    pushNotificationRepository.initNotifications();
  }

}