import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quizzed/theme/app_color.dart';
import '../theme/gradient_theme.dart';

class CompleteConfirmationDialog extends StatelessWidget {
  const CompleteConfirmationDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            'Your Quiz is completed successfully. Result will be live after quiz ends',
            style: kBodyText3Style().copyWith(color: blackColor),
          ),
          Lottie.asset(
            animate: true,
            width: 200,
            fit: BoxFit.contain,
            height: 200,
            'assets/images/complete.json',
          ),
        ],
      ),
      // content: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 110),
      //   child: Text(
      //     maxLines: 1,
      //     '${widget.resultModal.data?.CompleteConfirmationDialog} / ${widget.resultModal.data?.totalMarks}',
      //     style: kBodyText8Style().copyWith(color: blackColor),
      //   ),
      // ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kTeacherPrimaryColor,
          ),
          child: Column(
            children: [
              Center(
                  child: Text(
                "OK",
                style: kBodyText3Style(),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
