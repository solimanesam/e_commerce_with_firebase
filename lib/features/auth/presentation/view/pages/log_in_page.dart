import 'package:e_commerce_with_firebase/core/services/dependency_injection/auth_dependency_injection.dart';

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
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final AuthCubit cubit = context.read<AuthCubit>();

            return Stack(
              children: [
                Visibility(
                  visible: cubit.isVisible,
                  child: Image.asset(
                    'assets/coffee.jpg',
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                LoginForm()
              ],
            );
          },
        ),
      ),
    );
  }
}
