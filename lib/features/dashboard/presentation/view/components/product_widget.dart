import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

Widget productWidgt(
    {required BuildContext context,
    required String coffeekind,
    required String coffeename,
    required String image,
    required String price}) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .13,
      decoration: BoxDecoration(
          color: AppColors.lightDesinColor,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      coffeekind,
                      style: TextStyles.light12(context),
                    ),
                    Text(
                      coffeename,
                      style: TextStyles.semiBold16(
                          context: context, color: AppColors.secondryColor),
                    ),
                    Text(
                      '$price EGP',
                      style: TextStyles.semiBold16(
                          context: context, color: AppColors.secondryColor),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 3,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ))),
          )
        ],
      ),
    ),
  );
}
