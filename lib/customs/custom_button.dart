import 'package:flutter/material.dart';

Widget buttonWidget(
    {required String buttonText,
    required VoidCallback onTap,
    required backgroundColor,
    textColor,
    required bool isConnectionsButton, String connectionsCount = ''}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Text(buttonText),
            isConnectionsButton ? Text('', style: TextStyle(color: Colors.white),) : Text(''),
          ],
        ),
      ),
    ),
  );
}
