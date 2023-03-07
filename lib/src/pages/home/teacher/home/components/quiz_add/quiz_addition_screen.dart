import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';

import 'controller/quiz_addition_controller.dart';

class QuizAdditionScreen extends GetView<QuizAdditionController> {
  const QuizAdditionScreen({super.key});
  static const routeName = '/quizAddition';
  @override
  Widget build(BuildContext context) {
    final date = DateFormat('MM-dd hh:mm').format(DateTime.now());
    return Scaffold(
      backgroundColor: kTeacherPrimaryColor,
      appBar: const QuizAppbar(
          leading: SizedBox(),
          appBarColor: kTeacherPrimaryColor,
          titleText: 'Quizzed',
          preferredSize: Size.fromHeight(56)),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Please verify the details',
                        style: kBodyText3Style()
                            .copyWith(color: kTeacherPrimaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Your RegdNo :',
                      style: kBodyText3Style()
                          .copyWith(color: kTeacherPrimaryColor),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  controller.getAuthor(),
                                  style: kBodyText3Style()
                                      .copyWith(color: kTeacherPrimaryColor),
                                ),
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
