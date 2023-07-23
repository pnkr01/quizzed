import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/utils/quizElevatedButon.dart';

import '../theme/gradient_theme.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    required this.onpressedYes,
    required this.onpressedNo,
    required this.title,
  }) : super(key: key);
  final Function onpressedYes;
  final Function onpressedNo;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Text(
        title,
        style: kBodyText6Style().copyWith(color: kTeacherPrimaryColor),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: QuizElevatedButton(
              label: Text(
                'Yes',
                style: kBodyText6Style(),
              ),
              backgroundColor: greenColor,
              function: () {
                Get.back();
                onpressedYes();
              }),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: QuizElevatedButton(
              label: Text(
                'No',
                style: kBodyText6Style(),
              ),
              backgroundColor: kTeacherPrimaryLightColor,
              function: () {
                Get.back();
                onpressedNo();
              }),
        ),
      ],
    );
  }
}
