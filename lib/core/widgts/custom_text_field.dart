import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      required this.nameOfTextField,
      this.isSecure = false});

  TextEditingController controller = TextEditingController();
  String nameOfTextField;
  bool isSecure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (controller.text.isEmpty) {
          return '$nameOfTextField must not be empty';
        } else {
          return null;
        }
      },
      obscureText: isSecure,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondryColor)),
        labelText: nameOfTextField,
        labelStyle: TextStyles.semiBold20(context),
      ),
    );
  }
}
