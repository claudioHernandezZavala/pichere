import 'package:flutter/material.dart';

///snackbar to show when there is an eror
void errorSnackBar({required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
  ));
}

///snackbar to show to confirm an operation
void confirmationSnackBar(
    {required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: Colors.black,
  ));
}
