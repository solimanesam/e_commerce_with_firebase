import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

Container sizeContainer(BuildContext context,{required String sizeText,required double sizeOfIcon,required Color colorOfBorder}) {
    return Container(
        height: 44,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.brownColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:colorOfBorder, width: 1),
        ),
        child: Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset('assets/Vector.png', height: sizeOfIcon, width: sizeOfIcon),
            Text(sizeText,
                style: TextStyles.semiBold14auto(context,
                    color: AppColors.primaryColor)),
          ],
        ),
      );
  }