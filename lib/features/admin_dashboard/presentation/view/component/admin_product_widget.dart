import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

Widget adminproductWidget({
  required BuildContext context,
  required String coffeeKind,
  required String coffeeName,
  required String price,
  required String image,
  required VoidCallback onEdit,
  required VoidCallback onDelete,
}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * .18, 
      decoration: BoxDecoration(
        color: AppColors.lightDesinColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // معلومات القهوة
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    coffeeKind,
                    style: TextStyles.light12(context),
                  ),
                  Text(
                    coffeeName,
                    style: TextStyles.semiBold16(
                      context: context,
                      color: AppColors.secondryColor,
                    ),
                  ),
                  Text(
                    "Price: $price EGP",
                    style: TextStyles.light12(context).copyWith(
                      color: AppColors.secondryColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // صورة القهوة
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                    );
                  },
                ),
              ),
            ),
          ),
          // أيقونات التعديل والحذف
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: onEdit,
                  tooltip: "Edit Coffee",
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                  tooltip: "Delete Coffee",
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
