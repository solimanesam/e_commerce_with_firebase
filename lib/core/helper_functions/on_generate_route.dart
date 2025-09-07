import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/pages/admin_add_page.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/pages/admin_home_page.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/log_in_page.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/sign_up_page.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/pages/dashboard_page.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/pages/details_page.dart';
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
    case 'dashboard':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const DashboardPage(),
      );
    case 'detailsPage':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const DetailsPage(),
      );
    case 'adminhome':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const AdminDashboardPage(),
      );
    case 'adminadd':
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => AdminAddPage(),
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const LogInPage(),
  }
}
