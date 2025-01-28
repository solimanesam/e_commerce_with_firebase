import 'package:flutter/material.dart';

class AppTextFieldInputMdel {
  final String textFieldName;
  final BuildContext context;
  final TextEditingController controller;
  final bool obscure;
  final ValueChanged<String>? onChangedFunction;
  final IconData? icon;
  final VoidCallback? iconFunction;

  AppTextFieldInputMdel(
      {required this.textFieldName,
      required this.context,
      required this.controller,
      this.onChangedFunction,
      this.icon,
      this.iconFunction,
      this.obscure = false});
}
