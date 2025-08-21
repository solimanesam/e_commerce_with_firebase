import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/view/component/admin_product_widget.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Admin Dashboard',
          style: TextStyles.semiBold20(
            context,
          ),
        ),
        shape: Border(
            bottom: BorderSide(color: AppColors.secondryColor, width: 1)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondryColor,
        onPressed: () {
          Navigator.pushNamed(context, 'adminadd');
        },
        child: Icon(
          Icons.add,
          color: AppColors.primaryColor,
        ),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return adminproductWidget(
            context: context,
            coffeeKind: 'Black coffee',
            coffeeName: 'ICDE AMERICANO',
            image:
                'https://media-cdn.tripadvisor.com/media/photo-s/1d/9f/77/0b/turkish-coffee.jpg',
            price: "50",
            onEdit: () {},
            onDelete: () {},
          );
        },
      ),
    );
  }
}
