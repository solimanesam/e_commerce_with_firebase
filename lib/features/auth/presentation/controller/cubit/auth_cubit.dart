import 'package:bloc/bloc.dart';
import 'package:e_commerce_with_firebase/core/models/auth_input_model.dart';
import 'package:e_commerce_with_firebase/core/utils/enums.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/use_cases/log_in_user_use_case.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/use_cases/sign_up_user_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUserUseCase signUpUserUseCase;
  final LogInUserUseCase logInUserUseCase;
  AuthCubit(this.signUpUserUseCase, this.logInUserUseCase)
      : super(const AuthState());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;
    emit(AuthState(signUpStateEnum: RequestStateEnum.loading));
    final result = await signUpUserUseCase(
        parameters: AuthInputModel(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text));
    result.fold((l) {
      emit(AuthState(
          signUpMessage: l.message, signUpStateEnum: RequestStateEnum.failed));
    }, (r) {
      // clear fields and emit success
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      emit(AuthState(signUpStateEnum: RequestStateEnum.success));
    });
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    emit(AuthState(signInStateEnum: RequestStateEnum.loading));
    final result = await logInUserUseCase(
        parameters: AuthInputModel(
            email: emailController.text, password: passwordController.text));
    result.fold((l) {
      emit(AuthState(
          signInMessage: l.message, signInStateEnum: RequestStateEnum.failed));
    }, (r) {
      // clear fields
      emailController.clear();
      passwordController.clear();
      emit(AuthState(signInStateEnum: RequestStateEnum.success));
    });
  }
}
