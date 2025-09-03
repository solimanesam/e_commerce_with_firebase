import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/component/products.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/component/requests.dart';
import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shape: Border(
              bottom: BorderSide(color: AppColors.secondryColor, width: 1)),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Admin Dashboard',
            style: TextStyles.semiBold20(
              context,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.brownColor,
            labelColor: AppColors.brownColor,
            tabs: [
              Tab(icon: Icon(Icons.coffee), text: "Products"),
              Tab(icon: Icon(Icons.receipt_long), text: "Requests"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Products(),
            Requests(),
          ],
        ),
      ),
    );
  }
}
