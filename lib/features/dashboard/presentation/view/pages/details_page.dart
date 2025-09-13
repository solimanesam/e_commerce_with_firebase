import 'package:e_commerce_with_firebase/core/extentions/responsive_extention.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/utils/sized_boxs.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/textImage.jpg',
            height: context.height * .40,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 0.0,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(30.0),
                  height: context.height * .60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.blackDesignColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0))),
                  child: Column(
                    children: [
                      Row(children: [
                        Text(
                          'Winter\nspecial',
                          style: TextStyles.semiBold32auto(context),
                        ),
                        Expanded(child: SizedBoxs.sizedBoxH10),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: AppColors.lightDesinColor,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_outlined,
                              color: AppColors.greyDesignColor,
                            )),
                      ])
                    ],
                  ),
                ),
                // Container(height: context.height * .60,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       color: AppColors.coverColor.withValues(alpha: .1),
                //       borderRadius: BorderRadius.only(
                //           topRight: Radius.circular(20.0),
                //           topLeft: Radius.circular(20.0))),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
