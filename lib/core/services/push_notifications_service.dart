import 'package:e_commerce_with_firebase/core/models/notification_request_prameters.dart';
import 'package:e_commerce_with_firebase/core/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class PushNotificationsService {
  Future<void> init();
}

class PushNotificationsServiceImplByFirebaseMessaging
    implements PushNotificationsService {
  PushNotificationsServiceImplByFirebaseMessaging(
      {required this.localNotificationsService});

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final LocalNotificationsService localNotificationsService;

  @override
  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    final String? token = await _firebaseMessaging.getToken();
    _handelForeGroundCase();
    FirebaseMessaging.onBackgroundMessage(_handelBackGroundMessage);
  }

  void _handelForeGroundCase() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      localNotificationsService.show(NotificationRequestPrameters(
          id: 1,
          title: message.notification!.title!,
          body: message.notification!.body!,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              "foreground_channel_id",
              "foreground_channel_name",
              channelDescription: "foreground_channel_description",
              importance: Importance.max,
              priority: Priority.high,
            ),
          )));
    });
  }

  Future<void> _handelBackGroundMessage(RemoteMessage message) async {}
}
