import 'package:flutter/material.dart';

enum SnackBarType { success, failure }

void showCustomSnackBar(
  BuildContext context, {
  required String message,
  required SnackBarType type,
}) {
  final backgroundColor = type == SnackBarType.success
      ? Colors.greenAccent.shade700
      : Colors.redAccent.shade700;

  final icon = type == SnackBarType.success
      ? Icons.check_circle
      : Icons.error;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}
