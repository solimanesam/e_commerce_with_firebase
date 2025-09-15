import 'package:e_commerce_with_firebase/core/services/cache_service.dart';
import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/helper_functions/get_init_route.dart';
import 'package:e_commerce_with_firebase/core/helper_functions/on_generate_route.dart';
import 'package:e_commerce_with_firebase/core/services/local_notification_service.dart';
import 'package:e_commerce_with_firebase/core/services/push_notifications_service.dart';
import 'package:e_commerce_with_firebase/core/theme/app_theme.dart';
import 'package:e_commerce_with_firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DependencyInjection.init();

  await Future.wait([
    getIt<BaseCacheService>().cacheintIalization(),
    // getIt<PushNotificationsService>().init(),
    // getIt<LocalNotificationsService>().initialize(),
  ]);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: getInitRoute,
      theme: appTheme,
    ),
  );
}
