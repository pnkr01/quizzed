import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/join_quiz_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinQuizView extends GetView<JoinQuizCOntroller> {
  const JoinQuizView({super.key});
  static const String routeName = '/studentJoinQuiz';

  @override
  Widget build(BuildContext context) {
    Get.put(JoinQuizCOntroller());
    var controller = Get.find<JoinQuizCOntroller>();
    return Scaffold(
      bottomSheet: SizedBox(
        height: 70,
        width: double.infinity,
        child: Container(
            color: kPrimaryColor,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: darkJoinColor),
                onPressed: () {
                  controller.isTapStartJoining.value = true;
                  Focus.of(context).unfocus();
                },
                child: Obx(() => !controller.showLoading
                    ? Text(
                        'Continue',
                        style: kElevatedButtonTextStyle().copyWith(
                          color: whiteColor,
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: darkJoinColor,
                          strokeWidth: 1,
                        ),
                      )))),
      ),
      appBar: const QuizAppbar(
        appBarColor: kPrimaryColor,
        titleText: 'Join Quiz',
        preferredSize: Size.fromHeight(54),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Image.asset('assets/images/join.jpg'),
              SizedBox(
                height: 12.h,
              ),
              TextField(
                style: kBodyText3Style().copyWith(color: kPrimaryColor),
                obscureText: false,
                controller: controller.quizID.value,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  labelText: 'Enter Quiz ID',
                  labelStyle: kBodyText3Style().copyWith(color: kPrimaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14.sp),
                    ),
                    borderSide: const BorderSide(color: kPrimaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14.sp),
                    ),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
