import 'package:flutter/material.dart';

class ScaffoldMessage {
  void showSnackBar(
    String message,
    Color backgroundColor,
    BuildContext context,
  ) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
