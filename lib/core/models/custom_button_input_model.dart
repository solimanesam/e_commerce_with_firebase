import 'package:flutter/material.dart';

class CustomButtonInputModel {
  final String text;
  final VoidCallback? onPressed; // nullable
  final Color color;
  final Color textColor;
  final BuildContext context;

  const CustomButtonInputModel({
    required this.context,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
  });
}
