import 'package:flutter/material.dart';

class AppSnackBar {
  static void success(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: Colors.green,
          duration: const Duration(milliseconds: 2000),
        ),
      );
  }

  static void failure(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: Colors.red,
          duration: const Duration(milliseconds: 2000),
        ),
      );
  }
}
