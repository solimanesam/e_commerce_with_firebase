import 'package:e_commerce_with_firebase/core/services/dependency_injection/auth_dependency_injection.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_text_field.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt(), getIt()),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/coffee.png',
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final AuthCubit cubit = context.read<AuthCubit>();
                  return Form(
                    key: cubit.formKey,
                    child: Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.36,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome',
                                style: TextStyles.semiBold32(context)),
                            Text('Back!',
                                style: TextStyles.semiBold32(context)),
                          ],
                        ),
                        CustomTextField(
                          controller: cubit.emailController,
                          nameOfTextField: 'Email',
                        ),
                        CustomTextField(
                          controller: cubit.passwordController,
                          nameOfTextField: 'Password',
                          isSecure: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          textColor: AppColors.primaryColor,
                          color: AppColors.secondryColor,
                          text: 'LogIn',
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.login();
                            }
                          },
                        ),
                        CustomButton(
                          color: AppColors.primaryColor,
                          text: 'Create an account',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage(),));
                          }, textColor: AppColors.secondryColor,
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
