import 'package:flutter/material.dart';

extension BuildContextSnackbarExt on BuildContext {
  void showMessage(
    String message, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        showCloseIcon: true,
      ),
    );
  }

  void showMessageSuccess(String message) {
    showMessage(message, backgroundColor: Colors.green);
  }

  void showMessageError(String message) {
    showMessage(message, backgroundColor: Colors.red.shade900);
  }

  void showMessageWarning(String message) {
    showMessage(message, backgroundColor: Colors.yellow.shade800);
  }
}
