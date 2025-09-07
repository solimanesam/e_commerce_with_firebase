import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/row_of_quantity_buttons.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/components/size_components.dart';
import 'package:flutter/material.dart';

class TestPages extends StatelessWidget {
  const TestPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondryColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 25,
          children: [
            sizeComponents(context),
            Text(
              r'$4.95',
              style:
                  TextStyles.semiBold32(context, color: AppColors.primaryColor),
            ),
            rowOfquantityButtons(context)
          ],
        ),
      ),
    );
  }

 
}
// productWidgt(
//             context: context,
//             coffeekind: 'Black coffee',
//             coffeename: 'ICDE AMERICANO',
//             image:
//                 'https://media-cdn.tripadvisor.com/media/photo-s/1d/9f/77/0b/turkish-coffee.jpg'),
