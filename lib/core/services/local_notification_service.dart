import 'package:e_commerce_with_firebase/core/models/notification_request_prameters.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class LocalNotificationsService {
  Future<void> initialize();
  Future<void> show(NotificationRequestPrameters request);
}

class LocalNotificationsServiceByFlutterLocalNotifications
    extends LocalNotificationsService {
  final FlutterLocalNotificationsPlugin instance =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    final settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/launcher_icon"),
      iOS: DarwinInitializationSettings(), // لاحقا يتم عمل الاعدادات الخاصه بها
    );
    await instance.initialize(settings);
  }

  @override
  Future<void> show(NotificationRequestPrameters request) async {
    await instance.show(
      request.id,
      request.title,
      request.body,
      request.notificationDetails,
      payload: request.payload,
    );
  }
}
