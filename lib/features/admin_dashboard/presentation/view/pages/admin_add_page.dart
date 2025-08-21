import 'package:e_commerce_with_firebase/core/models/app_text_field_input_model.dart';
import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_text_field.dart';
import 'package:flutter/material.dart';

class AdminAddPage extends StatelessWidget {
  final List<String> coffeeKinds = [
    'Popular',
    'Black coffee',
    'Winter special',
    'Decaffe',
  ];

   AdminAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Add Coffee',
          style: TextStyles.semiBold20(context),
        ),
        shape: Border(
          bottom: BorderSide(color: AppColors.secondryColor, width: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          children: [
            customTextField(
              textFieldInputModel: TextFieldInputModel(
                context: context,
                controller: TextEditingController(),
                nameOfTextField: 'Name Of Coffee',
              ),
            ),
            customTextField(
              textFieldInputModel: TextFieldInputModel(
                context: context,
                controller: TextEditingController(),
                nameOfTextField: 'Price Of Coffee',
              ),
            ),
            DropdownButtonFormField<String>(
              items: coffeeKinds
                  .map((kind) =>
                      DropdownMenuItem(value: kind, child: Text(kind)))
                  .toList(),
              onChanged: (value) {
                /// لاحقاً هنستبدلها بـ Cubit
              },
              decoration: const InputDecoration(
                labelText: 'Coffee Kind',
                border: OutlineInputBorder(),
              ),
            ),
            InkWell(
              onTap: () {
                /// لاحقاً هنضيف اختيار الصورة بـ Cubit
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text('Select Coffee Image'),
                ),
              ),
            ),
            customButton(customButtonInputModel: CustomButtonInputModel(
              context: context,
              color: AppColors.secondryColor,
              text: 'Add Coffee',
              textColor: AppColors.primaryColor,
              onPressed: () {},
            ))
          ],
        ),
      ),
    );
  }
}
