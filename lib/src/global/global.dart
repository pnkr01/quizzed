import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/theme/gradient_theme.dart';

showSnackBar(var message, Color color, Color? textColor) {
  return Get.rawSnackbar(
      title: GLobal.appName.toString(),
      messageText: Text(
        message.toString(),
        style: kBodyText3Style(),
      ),
      // message: message,
      backgroundColor: color,
      icon: Container(
        margin: const EdgeInsets.only(left: 4, right: 4),
        child: Image.asset(
          'assets/images/logo.png',
          // fit: BoxFit.cover,
          // height: 60,
          // width: 10,
        ),
      ));
}

quizDebugPrint(var e) {
  if (kDebugMode) {
    print(e.toString());
  }
}
