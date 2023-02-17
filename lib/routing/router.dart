import 'package:flutter/material.dart';

class CustomRouter {
  static navigateToScreen(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => route));
  }

  static goBack(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }
}
