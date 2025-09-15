import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

Widget customButton({required CustomButtonInputModel customButtonInputModel}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: customButtonInputModel.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: customButtonInputModel.color,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.secondryColor, width: 2),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            customButtonInputModel.text,
            style: TextStyles.semiBold16(
              context: customButtonInputModel.context,
              color: customButtonInputModel.textColor,
            ),
          ),
        ],
      ),
    ),
  );
}
