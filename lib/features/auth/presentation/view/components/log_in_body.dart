import 'package:e_commerce_with_firebase/core/models/app_text_field_input_model.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/core/widgts/appTextField.dart';
import 'package:e_commerce_with_firebase/core/widgts/custom_button.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class LogInBody extends StatelessWidget {
  LogInBody({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
        child: Form(
          key: formKey,
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
                      controller: emailController),
                  context: context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getAppTextfield(
                      appTextFieldInputMdel: AppTextFieldInputMdel(
                          textFieldName: 'password',
                          context: context,
                          controller: passwordController),
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
                  if (formKey.currentState!.validate()) {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
