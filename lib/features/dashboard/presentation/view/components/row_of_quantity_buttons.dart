import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:flutter/material.dart';

Row rowOfquantityButtons(BuildContext context) {
  return Row(
    spacing: 10,
    children: [
      Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.secondryColor,
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('-',
                  style: TextStyles.semiBold14auto(context,
                      color: AppColors.primaryColor)),
              Text('1',
                  style: TextStyles.semiBold14auto(context,
                      color: AppColors.primaryColor)),
              Text('+',
                  style: TextStyles.semiBold14auto(context,
                      color: AppColors.primaryColor)),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: customButton(
            customButtonInputModel: CustomButtonInputModel(
          context: context,
          color: AppColors.primaryColor,
          text: 'Add to cart',
          onPressed: () {},
          textColor: AppColors.secondryColor,
        )),
      ),
    ],
  );
}
