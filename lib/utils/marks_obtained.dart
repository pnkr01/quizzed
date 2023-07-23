import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quizzed/src/model/result_model.dart';
import 'package:quizzed/src/pages/home/student/home/components/result/controller/quiz_result_controller.dart';
import 'package:quizzed/src/pages/home/student/home/student_home.dart';
import 'package:quizzed/theme/app_color.dart';

import '../src/pages/home/student/home/components/joinQuiz/components/controller/join_quiz_session_controller.dart';
import '../theme/gradient_theme.dart';

class MarksObtained extends StatefulWidget {
  const MarksObtained({
    Key? key,
    required this.resultModal,
    this.isComingFromResult = false,
  }) : super(key: key);
  final ResultModal resultModal;
  final bool? isComingFromResult;

  @override
  State<MarksObtained> createState() => _MarksObtainedState();
}

class _MarksObtainedState extends State<MarksObtained> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            '${widget.resultModal.message}',
            style: kBodyText3Style().copyWith(color: blackColor),
          ),
          Lottie.asset(
            animate: true,
            width: 200,
            fit: BoxFit.contain,
            height: 200,
            'assets/images/completed.json',
          ),
        ],
      ),
      content: widget.resultModal.data?.marksObtained != null &&
              widget.resultModal.data?.totalMarks != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 110),
              child: Text(
                maxLines: 1,
                '${widget.resultModal.data?.marksObtained} / ${widget.resultModal.data?.totalMarks}',
                style: kBodyText8Style().copyWith(color: blackColor),
              ),
            )
          : const Text('Error try again'),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (widget.isComingFromResult!) {
              var result = Get.find<QuizResultScreenController>();
              result.quizID.clear();
              result.isLoading.value = false;
              final currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
              Get.back();
            } else {
              Get.offAllNamed(StudentHome.routeName);
              var controller = Get.find<JoinQuizSessionController>();
              controller.timer?.cancel();
            }
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
