import 'package:e_commerce_with_firebase/core/constants/view_constants.dart';
import 'package:e_commerce_with_firebase/core/models/app_text_field_input_model.dart';
import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/utils/enums.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_snake_bar.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_text_field.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt(), getIt()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.signUpStateEnum == RequestStateEnum.success) {
                showCustomSnackBar(context,
                    message: "Sign Up Success", type: SnackBarType.success);
                Navigator.of(context).pushReplacementNamed('login');
              }

              if (state.signUpStateEnum == RequestStateEnum.failed) {
                showCustomSnackBar(context,
                    message: state.signUpMessage, type: SnackBarType.failure);
              }
            },
            builder: (context, state) {
              final AuthCubit cubit = context.read<AuthCubit>();
              List<TextEditingController> logInTextFieldControllers = [
                cubit.emailController,
                cubit.passwordController,
                cubit.nameController
              ];
              return Form(
                key: cubit.formKey,
                child: Column(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                        3,
                        (index) => customTextField(
                            textFieldInputModel: TextFieldInputModel(
                                context: context,
                                isSecure: index == 1,
                                controller: logInTextFieldControllers[index],
                                nameOfTextField: ViewConstants
                                    .logInTextFieldsNames[index]))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(
                            ViewConstants.alreadyHaveAccount,
                            style: TextStyles.semiBold20(context),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LogInPage(),
                            ));
                          },
                        ),
                      ],
                    ),
                    customButton(
                        customButtonInputModel: CustomButtonInputModel(
                      context: context,
                      loadingVisible:
                          state.signUpStateEnum == RequestStateEnum.loading,
                      textColor: AppColors.primaryColor,
                      color: AppColors.secondryColor,
                      text: 'SignUp',
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.signUp();
                        }
                      },
                    )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
