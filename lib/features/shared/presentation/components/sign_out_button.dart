import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/services/cache_service.dart';
import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BaseCacheService cacheService = getIt<BaseCacheService>();

    return customButton(
        customButtonInputModel: CustomButtonInputModel(
      context: context,
      color: Colors.red,
      text: 'Sign Out',
      textColor: AppColors.whiteDesignColor,
      onPressed: () {
        cacheService.deletecache();

        Navigator.of(context)
            .pushNamedAndRemoveUntil('login', (route) => false);
      },
    ));
  }
}
