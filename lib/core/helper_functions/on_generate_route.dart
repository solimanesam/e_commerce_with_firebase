// class Routes {
//  static List<Route> initroute = [
//    MaterialPageRoute<dynamic>(builder: (BuildContext context) => const login_page(),),
//     MaterialPageRoute<dynamic>(builder: (BuildContext context) => const Onboarding_page(),),
//  ];

import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/log_in_page.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "login":
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LogInPage(),
      );
    case 'signUp':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const SignUpPage(),
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LogInPage(),
      );
  }
}
