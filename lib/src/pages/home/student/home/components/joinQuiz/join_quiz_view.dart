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
            color: kQuizPrimaryColor,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kQuizPrimaryColor),
                onPressed: () {
                  controller.isTapStartJoining.value = true;
                  controller.checkEmptyFilled();
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
                          color: whiteColor,
                          strokeWidth: 1,
                        ),
                      )))),
      ),
      appBar: const QuizAppbar(
        appBarColor: kQuizPrimaryColor,
        titleText: 'Join Quiz',
        preferredSize: Size.fromHeight(54),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                width: 500,
                child: Image.asset('assets/images/join.jpg'),
              ),
              SizedBox(
                height: 12.h,
              ),
              TextField(
                style: kBodyText3Style().copyWith(color: kQuizPrimaryColor),
                obscureText: false,
                controller: controller.quizID.value,
                cursorColor: kQuizPrimaryColor,
                decoration: InputDecoration(
                  hintText: 'Enter Quiz ID',
                  hintStyle: kBodyText3Style().copyWith(color: greyColor),
                  labelText: 'Enter Quiz ID',
                  labelStyle:
                      kBodyText3Style().copyWith(color: kQuizPrimaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14.sp),
                    ),
                    borderSide: const BorderSide(color: kQuizPrimaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14.sp),
                    ),
                    borderSide: const BorderSide(
                      color: kQuizPrimaryColor,
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
