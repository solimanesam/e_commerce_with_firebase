import 'package:e_commerce_with_firebase/core/services/cache_service.dart';
import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BaseCacheService cacheService = getIt<BaseCacheService>();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.secondryColor, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () {
          cacheService.deletecache();

          Navigator.of(context).pushNamedAndRemoveUntil(
            'login',
            (route) => false,
          );
        },
        child: const Text(
          "Sign Out",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
