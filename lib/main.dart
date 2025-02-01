import 'package:e_commerce_with_firebase/core/services/dependency_injection/auth_dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_theme.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/sign_up_page.dart';
import 'package:e_commerce_with_firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AuthDependencyInjection.init();
 

  MaterialApp myApp = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignUpPage(),
    theme: appTheme,
  );
  runApp(myApp);
}
