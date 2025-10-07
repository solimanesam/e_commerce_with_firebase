import 'package:e_commerce_with_firebase/core/models/app_text_field_input_model.dart';
import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_snake_bar.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_text_field.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/presentation/controllers/cubit/admin_dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUpdatePage extends StatefulWidget {
  const AdminUpdatePage({
    super.key,
    required this.coffee,
  });
  final CoffeeEntity coffee;
  @override
  State<AdminUpdatePage> createState() => _AdminUpdatePageState();
}

class _AdminUpdatePageState extends State<AdminUpdatePage> {
  final List<String> coffeeKinds = [
    'Popular',
    'Black coffee',
    'Winter special',
    'Decaffe',
  ];

  // Controllers
  late TextEditingController updateNameController;
  late TextEditingController updatePriceController;
  late TextEditingController updateImageUrlController;

  String? updateSelectedKind;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    updateNameController = TextEditingController(text: widget.coffee.name);
    updatePriceController =
        TextEditingController(text: widget.coffee.price.toString());
    updateImageUrlController =
        TextEditingController(text: widget.coffee.imageUrl);
    updateSelectedKind = widget.coffee.kind;
  }

  @override
  void dispose() {
    updateNameController.dispose();
    updatePriceController.dispose();
    updateImageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AdminDashboardCubit>();
    return BlocListener<AdminDashboardCubit, AdminDashboardState>(
      listener: (context, state) {
        if (state is AdminDashboardSuccess) {
          showCustomSnackBar(context,
              message: 'Coffee Updated', type: SnackBarType.success);
          controller.getAllCoffee();
          Navigator.pushNamedAndRemoveUntil(
              context, 'adminhome', (route) => false);
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
            'Update Coffee',
            style: TextStyles.semiBold20(context),
          ),
          shape: Border(
            bottom: BorderSide(color: AppColors.secondryColor, width: 1),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(spacing: 20, children: [
              customTextField(
                textFieldInputModel: TextFieldInputModel(
                  context: context,
                  controller: updateNameController,
                  nameOfTextField: 'Name Of Coffee',
                ),
              ),
              customTextField(
                textFieldInputModel: TextFieldInputModel(
                  context: context,
                  controller: updatePriceController,
                  nameOfTextField: 'Price Of Coffee',
                ),
              ),
              DropdownButtonFormField<String>(
                initialValue: updateSelectedKind, // default value
                items: coffeeKinds
                    .map((kind) =>
                        DropdownMenuItem(value: kind, child: Text(kind)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    updateSelectedKind = value;
                  });
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
                  controller: updateImageUrlController,
                  nameOfTextField: 'ImageUrl',
                ),
              ),
              BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
                builder: (context, state) {
                  return customButton(
                    customButtonInputModel: CustomButtonInputModel(
                      context: context,
                      text: state is AdminDashboardLoading
                          ? 'Updating...'
                          : 'Update',
                      color: AppColors.secondryColor,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.updateCoffee(
                            coffee: CoffeeModel(
                              id: widget.coffee.id,
                              name: updateNameController.text,
                              price: double.parse(updatePriceController.text),
                              kind: updateSelectedKind!,
                              imageUrl: updateImageUrlController.text,
                            ),
                          );
                        }
                      },
                      textColor: AppColors.primaryColor,
                    ),
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
