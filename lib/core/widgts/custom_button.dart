import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool loadingVisible;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.textColor,
      this.loadingVisible = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.secondryColor, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          spacing: 5.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style:
                    TextStyles.semiBold16(context: context, color: textColor)),
            Visibility(
                visible: loadingVisible,
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        color: AppColors.primaryColor, strokeWidth: 2)))
          ],
        ),
      ),
    );
  }
}
