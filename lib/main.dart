import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/helper_functions/get_init_route.dart';
import 'package:e_commerce_with_firebase/core/helper_functions/on_generate_route.dart';
import 'package:e_commerce_with_firebase/core/theme/app_theme.dart';
import 'package:e_commerce_with_firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection.init();
 

  MaterialApp myApp = MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: onGenerateRoute,
    initialRoute: getInitRoute,
    theme: appTheme,
  );
  runApp(myApp);
}

