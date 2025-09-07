import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationRequestPrameters {
  final int id;
  final String title;
  final String body;
  final String? payload;

  /// تفاصيل الإشعار
  final NotificationDetails notificationDetails;

  const NotificationRequestPrameters({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    required this.notificationDetails,
  });
}
