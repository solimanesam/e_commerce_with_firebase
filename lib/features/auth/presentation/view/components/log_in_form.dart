import 'package:e_commerce_with_firebase/core/constants/view_constants.dart';
import 'package:e_commerce_with_firebase/core/extentions/responsive_extention.dart';
import 'package:e_commerce_with_firebase/core/models/app_text_field_input_model.dart';
import 'package:e_commerce_with_firebase/core/models/custom_button_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/utils/enums.dart';
import 'package:e_commerce_with_firebase/core/utils/sized_boxs.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_text_field.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/components/go_to_sign_up_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final AuthCubit cubit = context.read<AuthCubit>();

        List<TextEditingController> logInTextFieldControllers = [
          cubit.emailController,
          cubit.passwordController
        ];

        return Form(
          key: cubit.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: cubit.isVisible,
                    child: SizedBox(
                      height: context.height * 1 / 3 + 15.0,
                    )),
                Expanded(
                  child: Visibility(
                      visible: cubit.isVisible,
                      child: Text(ViewConstants.welcomeBack,
                          style: TextStyles.semiBold32(context))),
                ),
                ...List.generate(
                    2,
                    (index) => Visibility(
                          visible: cubit.isVisible1,
                          child: customTextField(
                              textFieldInputModel: TextFieldInputModel(
                                  context: context,
                                  controller: logInTextFieldControllers[index],
                                  nameOfTextField: ViewConstants
                                      .logInTextFieldsNames[index])),
                        )),
                customButton(
                    customButtonInputModel: CustomButtonInputModel(
                  context: context,
                  loadingVisible:
                      state.signInStateEnum == RequestStateEnum.loading,
                  textColor: AppColors.primaryColor,
                  color: AppColors.secondryColor,
                  text: ViewConstants.logInButtonText,
                  onPressed: () {
                    cubit.login();
                  },
                )),
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
