import 'package:e_commerce_with_firebase/features/shared/presentation/components/sign_out_button.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        SignOutButton(),
      ],
    );
  }
}
