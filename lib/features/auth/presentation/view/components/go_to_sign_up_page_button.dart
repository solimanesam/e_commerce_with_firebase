import 'package:e_commerce_with_firebase/core/constants/view_constants.dart';
import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
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
    return customButton(
        customButtonInputModel: CustomButtonInputModel(
      context: context,
      color: AppColors.primaryColor,
      text: ViewConstants.createAccountButtonText,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignUpPage(),
        ));
      },
      textColor: AppColors.secondryColor,
    ));
  }
}
