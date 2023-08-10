import 'package:flutter/material.dart';

enum SnackBarStatus {
  normal(Colors.black54, Colors.white),
  success(Colors.green, Colors.white),
  error(Colors.red, Colors.white);

  final Color backgroundColor;
  final Color textColor;

  const SnackBarStatus(this.backgroundColor, this.textColor);
}

void showSnackBar(BuildContext context, String message, SnackBarStatus status) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: status.textColor)),
      duration: const Duration(seconds: 3),
      backgroundColor: status.backgroundColor,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}
