import 'package:flutter/material.dart';

class TextFieldInputModel {
  TextFieldInputModel(
      {required this.context,
      required this.controller,
      required this.nameOfTextField,
      this.isSecure = false});

  final TextEditingController controller;
  final String nameOfTextField;
  final bool isSecure;
  final BuildContext context;
}
