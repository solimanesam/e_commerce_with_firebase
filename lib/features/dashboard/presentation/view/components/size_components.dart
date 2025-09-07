import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/size_container.dart';
import 'package:flutter/material.dart';

Column sizeComponents(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 10,
    children: [
      Text(
        'Size',
        style: TextStyles.semiBold16(
            context: context, color: AppColors.primaryColor),
      ),
      Row(
        spacing: 10,
        children: [
          Expanded(
              flex: 1,
              child: sizeContainer(context,
                  sizeText: '250',
                  sizeOfIcon: 17,
                  colorOfBorder: AppColors.brownColor)),
          Expanded(
              flex: 1,
              child: sizeContainer(context,
                  sizeText: '350',
                  sizeOfIcon: 20,
                  colorOfBorder: AppColors.primaryColor)),
          Expanded(
              flex: 1,
              child: sizeContainer(context,
                  sizeText: '450',
                  sizeOfIcon: 23,
                  colorOfBorder: AppColors.brownColor)),
        ],
      ),
    ],
  );
}
