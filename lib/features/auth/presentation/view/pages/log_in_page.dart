import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/view/components/log_in_form.dart';
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
              'assets/coffee.jpg',
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            LoginForm()
          ],
        ),
      ),
    );
  }
}
