import 'package:e_commerce_with_firebase/core/models/app_text_field_input_model.dart';
import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_snake_bar.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_text_field.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/controllers/cubit/admin_dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final controller = context.read<AdminDashboardCubit>();
    return BlocListener<AdminDashboardCubit, AdminDashboardState>(
      listener: (context, state) {
        if (state is AdminDashboardSuccess) {
          showCustomSnackBar(context,
              message: 'Coffee Added', type: SnackBarType.success);
          controller.clearControllers();
          controller.getAllCoffee();
          Navigator.pushNamedAndRemoveUntil(context, 'adminhome', (route) => false);
        } else if (state is AdminDashboardFailure) {
          showCustomSnackBar(context,
              message: state.message, type: SnackBarType.failure);
        }
      },
      child: Scaffold(
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
          child: Form(
            key: controller.formKey,
            child: Column(
              spacing: 20,
              children: [
                customTextField(
                  textFieldInputModel: TextFieldInputModel(
                    context: context,
                    controller: controller.nameController,
                    nameOfTextField: 'Name Of Coffee',
                  ),
                ),
                customTextField(
                  textFieldInputModel: TextFieldInputModel(
                    context: context,
                    controller: controller.priceController,
                    nameOfTextField: 'Price Of Coffee',
                  ),
                ),
                DropdownButtonFormField<String>(
                  items: coffeeKinds
                      .map((kind) =>
                          DropdownMenuItem(value: kind, child: Text(kind)))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedKind = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select coffee kind';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Coffee Kind',
                    border: OutlineInputBorder(),
                  ),
                ),
                customTextField(
                  textFieldInputModel: TextFieldInputModel(
                    context: context,
                    controller: controller.imageUrlController,
                    nameOfTextField: 'Image Url',
                  ),
                ),
                BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
                  builder: (context, state) {
                    return customButton(
                        customButtonInputModel: CustomButtonInputModel(
                      context: context,
                      color: AppColors.secondryColor,
                      text:state is AdminDashboardLoading ? 'Adding...' : 'Add Coffee',
                      textColor: AppColors.primaryColor,
                      onPressed: () {
                        controller.addcoffee();
                      },
                    ));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
