import 'package:flutter/material.dart';
class CustomIconSnackBar {
  void showSnackBar(
      {required BuildContext context, required Icon content}) {
    final snackBar = SnackBar(
      content: Icon(Icons.signal_wifi_off_sharp,
        color: Colors.white,),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 10,
    );
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()..showSnackBar(snackBar);
  }
}