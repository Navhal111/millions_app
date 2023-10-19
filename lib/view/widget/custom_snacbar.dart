import 'package:flutter/material.dart';

void showCustomSnackBar(String message, BuildContext context,
    {bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          )),
    ));
  }
}
