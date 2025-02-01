import 'package:e_commerce_with_firebase/core/models/app_text_field_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/appTextField.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInBody extends StatelessWidget {
  const LogInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        AuthCubit cubit = context.read<AuthCubit>();
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
            child: Form(
              key: cubit.formKey,
              child: Column(
                spacing: 40,
                children: [
                  Text(
                    'LogIn',
                    style: TextStyles.semiBold32(context),
                  ),
                  getAppTextfield(
                      appTextFieldInputMdel: AppTextFieldInputMdel(
                          textFieldName: 'email',
                          context: context,
                          controller: cubit.emailController),
                      context: context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      getAppTextfield(
                          appTextFieldInputMdel: AppTextFieldInputMdel(
                              textFieldName: 'password',
                              context: context,
                              controller: cubit.passwordController),
                          context: context),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ));
                          },
                          child: Text(
                            'Dont you have an account?',
                            style: TextStyles.regular14_150(context),
                          ))
                    ],
                  ),
                  CustomButton(
                    text: 'Log In',
                    onPressed: () {
                      cubit.login();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
