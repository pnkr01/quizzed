import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/join_quiz_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/widget/custom_text_for_file.dart';

class JoinQuizView extends StatelessWidget {
  const JoinQuizView({super.key});
  static const String routeName = '/studentJoinQuiz';

  @override
  Widget build(BuildContext context) {
    var joinQuizController = Get.find<JoinQuizCOntroller>();
    return Scaffold(
      //backgroundColor: kPrimaryColor,
      appBar: const QuizAppbar(
        appBarColor: kPrimaryColor,
        titleText: 'Join Quiz',
        preferredSize: Size.fromHeight(50),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/join.jpg'),
            SizedBox(
              height: 12.h,
            ),
            CustomTextFormField(
              labelText: 'Enter Quiz ID',
              borderColor: redColor,
              cursorColor: kPrimaryColor,
              labelColor: whiteColor,
              isObscureText: false,
              controller: joinQuizController.quizID.value,
            )
          ],
        ),
      ),
    );
  }
}
