import 'package:flutter/material.dart';
import 'package:quiz/theme/app_color.dart';

circularProgress() {
  return Container(
    padding: const EdgeInsets.only(top: 12.0),
    alignment: Alignment.center,
    child: const CircularProgressIndicator(
      backgroundColor: kTeacherPrimaryColor,
      color: Colors.white,
    ),
  );
}
