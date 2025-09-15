import 'package:e_commerce_with_firebase/core/constants/view_constants.dart';
import 'package:e_commerce_with_firebase/core/extentions/responsive_extention.dart';
import 'package:e_commerce_with_firebase/core/helper_functions/get_init_route.dart';
import 'package:e_commerce_with_firebase/core/models/app_text_field_input_model.dart';
import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/utils/enums.dart';
import 'package:e_commerce_with_firebase/core/utils/sized_boxs.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_snake_bar.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_text_field.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/components/go_to_sign_up_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.signInStateEnum == RequestStateEnum.success) {
          showCustomSnackBar(context,
              message: "Log In Success", type: SnackBarType.success);

          Navigator.of(context).pushNamedAndRemoveUntil(
            getInitRoute,
            (route) => false,
          );
        }

        if (state.signInStateEnum == RequestStateEnum.failed) {
          showCustomSnackBar(context,
              message: state.signInMessage, type: SnackBarType.failure);
        }
      },
      builder: (context, state) {
        final AuthCubit cubit = context.read<AuthCubit>();

        List<TextEditingController> logInTextFieldControllers = [
          cubit.emailController,
          cubit.passwordController
        ];

        final isLoading = state.signInStateEnum == RequestStateEnum.loading;

        return Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.height * 1 / 3 + 15.0,
                ),
                Expanded(
                    child: Text(ViewConstants.welcomeBack,
                        style: TextStyles.semiBold32(context,
                            color: AppColors.secondryColor))),
                ...List.generate(
                    2,
                    (index) => customTextField(
                        textFieldInputModel: TextFieldInputModel(
                            context: context,
                            isSecure: index == 1,
                            controller: logInTextFieldControllers[index],
                            nameOfTextField:
                                ViewConstants.logInTextFieldsNames[index]))),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return customButton(
                        customButtonInputModel: CustomButtonInputModel(
                      context: context,
                      textColor: AppColors.primaryColor,
                      color: AppColors.secondryColor,
                      text: state.signInStateEnum == RequestStateEnum.loading
                          ? "Loading..."
                          : ViewConstants.logInButtonText,
                      onPressed: isLoading ? null : () => cubit.login(),
                    ));
                  },
                ),
                const GoToSignUpButton(),
                SizedBoxs.sizedBoxH30
              ],
            ),
          ),
        );
      },
    );
  }
}
