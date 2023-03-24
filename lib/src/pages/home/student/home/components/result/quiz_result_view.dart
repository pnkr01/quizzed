import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/student/home/components/result/controller/quiz_result_controller.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizTextField.dart';

import '../../../../../../../theme/app_color.dart';
import '../../../../../../../utils/quizAppBar.dart';

class QuizResultView extends GetView<QuizResultScreenController> {
  const QuizResultView({super.key});
  static const String routeName = '/studentQuizResult';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: SizedBox(
          height: 70,
          width: double.infinity,
          child: Container(
            color: kTeacherPrimaryColor,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kTeacherPrimaryColor),
              onPressed: () {
                controller.isLoading.value = true;
                //  controller.isTapStartJoining.value = true;
                controller.fetchResult();
              },
              child: Obx(
                () => controller.isLoading.value == true
                    ? const Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: whiteColor,
                      ))
                    : Text('Okay', style: kBodyText2Style()),
              ),
            ),
          ),
        ),
        backgroundColor: whiteColor,
        appBar: const QuizAppbar(
          appBarColor: kTeacherPrimaryColor,
          titleText: 'Result',
          preferredSize: Size.fromHeight(54),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuizTextFormField(
                contentColor: kTeacherPrimaryColor,
                labelText: 'Quiz ID',
                hintText: 'Enter quizID',
                borderColor: kQuizPrimaryColor,
                cursorColor: kQuizPrimaryColor,
                hintColor: kQuizPrimaryColor,
                isObscureText: false,
                controller: controller.quizID,
              ),
            ),
          ],
        ));
  }
}
