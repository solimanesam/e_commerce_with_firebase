import 'package:e_commerce_with_firebase/firebase_options.dart';
import 'package:e_commerce_with_firebase/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MaterialApp myApp = MaterialApp(
    home: Test(),
  );
  runApp(myApp);
}
