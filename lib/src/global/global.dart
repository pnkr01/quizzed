import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(String message, Color color, Color textColor) {
  return Get.snackbar(
    "Quizzed",
    message,
    backgroundColor: color,
    colorText: textColor,
  );
}
