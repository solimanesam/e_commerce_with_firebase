import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class GoToSignUpButton extends StatelessWidget {
  const GoToSignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: AppColors.primaryColor,
      text: 'Create an account',
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignUpPage(),
        ));
      },
      textColor: AppColors.secondryColor,
    );
  }
}
