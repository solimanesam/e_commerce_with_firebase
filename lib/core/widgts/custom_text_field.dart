import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class TextFieldInputModel {
  TextFieldInputModel(
      {required this.context,
      required this.controller,
      required this.nameOfTextField,
      this.isSecure = false});

  final TextEditingController controller;
  final String nameOfTextField;
  final bool isSecure;
  final BuildContext context;
}

Widget customTextField({required TextFieldInputModel textFieldInputModel}) {
  return TextFormField(
    controller: textFieldInputModel.controller,
    validator: (value) {
      if (textFieldInputModel.controller.text.isEmpty) {
        return '${textFieldInputModel.nameOfTextField} must not be empty';
      } else {
        return null;
      }
    },
    obscureText: textFieldInputModel.isSecure,
    decoration: InputDecoration(
      border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondryColor)),
      labelText: textFieldInputModel.nameOfTextField,
      labelStyle: TextStyles.semiBold20(textFieldInputModel.context),
    ),
  );
}
