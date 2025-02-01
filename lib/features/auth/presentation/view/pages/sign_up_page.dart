import 'package:e_commerce_with_firebase/core/services/dependency_injection/auth_dependency_injection.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/components/sign_up_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt(),getIt()),
      child: Scaffold(
        body: SignUpBody(),
      ),
    );
  }
}
