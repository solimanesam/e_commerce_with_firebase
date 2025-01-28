import 'package:e_commerce_with_firebase/core/models/app_text_field_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';

import 'package:flutter/material.dart';

Widget getAppTextfield(
        {required AppTextFieldInputMdel appTextFieldInputMdel,
        required BuildContext context}) =>
    TextFormField(
      obscureText: appTextFieldInputMdel.obscure,
      controller: appTextFieldInputMdel.controller,
      validator: (value) {
        if (appTextFieldInputMdel.controller.text.isEmpty) {
          return '${appTextFieldInputMdel.textFieldName} must not be empty';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        filled: true,
        fillColor: AppColors.secondryColor,
        hintText: appTextFieldInputMdel.textFieldName,
        hintStyle: TextStyles.regular16_120(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
