import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/product_widget.dart';
import 'package:flutter/material.dart';

class TestPages extends StatelessWidget {
  const TestPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondryColor,
      body: Center(
        child: productWidgt(
            context: context,
            coffeekind: 'Black coffee',
            coffeename: 'ICDE AMERICANO',
            image:
                'https://media-cdn.tripadvisor.com/media/photo-s/1d/9f/77/0b/turkish-coffee.jpg'),
      ),
    );
  }
}
