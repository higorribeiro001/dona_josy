import 'package:flutter/material.dart';

class NavigatorApp {
  void nextScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
