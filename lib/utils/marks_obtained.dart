import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz/src/model/result_model.dart';
import 'package:quiz/src/pages/home/student/home/student_home.dart';
import 'package:quiz/theme/app_color.dart';

import '../src/pages/home/student/home/components/joinQuiz/components/controller/join_quiz_session_controller.dart';
import '../theme/gradient_theme.dart';

class MarksObtained extends StatelessWidget {
  const MarksObtained({
    Key? key,
    required this.resultModal,
  }) : super(key: key);
  final ResultModal resultModal;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      title: Text(
        resultModal.message.toString().replaceRange(0, 5, 'Your'),
        style: kBodyText3Style().copyWith(color: blackColor),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 110),
        child: Text(
          maxLines: 1,
          '${resultModal.data?.marksObtained} / ${resultModal.data?.totalMarks}',
          style: kBodyText8Style().copyWith(color: blackColor),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.offAllNamed(StudentHome.routeName);
            var controller = Get.find<JoinQuizSessionController>();
            controller.timer?.cancel();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kTeacherPrimaryColor,
          ),
          child: Center(
              child: Text(
            "OK",
            style: kBodyText3Style(),
          )),
        ),
      ],
    );
  }
}
