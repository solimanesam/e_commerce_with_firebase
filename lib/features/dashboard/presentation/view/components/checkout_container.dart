import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:flutter/material.dart';

class ChectOutContainer extends StatelessWidget {
  const ChectOutContainer({
    super.key,
    required this.totalPrice,
  });

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: TextStyles.semiBold18(
                  context,
                ),
              ),
              Text(
                "${totalPrice.toStringAsFixed(2)} EGP",
                style: TextStyles.semiBold18(
                  context,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
              width: double.infinity,
              child: customButton(
                  customButtonInputModel: CustomButtonInputModel(
                      context: context,
                      text: 'Ckeckout',
                      onPressed: () {},
                      color: AppColors.primaryColor,
                      textColor: AppColors.secondryColor))),
        ],
      ),
    );
  }
}
