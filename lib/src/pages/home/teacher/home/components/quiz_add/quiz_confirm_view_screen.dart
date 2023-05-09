import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiz/src/pages/home/teacher/home/components/create/parsing/parsing.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';
import 'package:quiz/utils/quizElevatedButon.dart';

import '../../../../../../global/global.dart';
import 'controller/quiz_view_screen_controller.dart';

class QuizAdditionScreen extends GetView<QuizAdditionController> {
  const QuizAdditionScreen({super.key});
  static const routeName = '/quizAddition';
  @override
  Widget build(BuildContext context) {
    Get.put(QuizAdditionController());
    return WillPopScope(
      onWillPop: () async => await showDialog(
        context: context,
        builder: (c) => AlertDialog(
          key: key,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Warning',
                style: kBodyText2Style().copyWith(color: kTeacherPrimaryColor),
              ),
              const SizedBox(height: 8.0),
              Text(
                'This quiz will be removed. Do you want to continue ?',
                style: kBodyText3Style()
                    .copyWith(color: kTeacherPrimaryLightColor),
              ),
              const SizedBox(height: 15.0),
              QuizElevatedButton(
                  label: const Text('Erase'),
                  backgroundColor: kTeacherPrimaryColor,
                  function: () async {
                    Get.find<QuizAdditionController>()
                        .handleEraseButton(controller.getQuizId());
                  }),
              const SizedBox(height: 8.0),
              QuizElevatedButton(
                  label: const Text('Cancel'),
                  backgroundColor: kTeacherPrimaryColor,
                  function: () {
                    quizDebugPrint('Cancel');
                    Get.back();
                  })
            ],
          ),
        ),
      ),
      child: Scaffold(
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
                  child: SingleChildScrollView(
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
                          'Your RegdNo ',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                controller.getAuthor(),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Description',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                controller
                                    .getDescription()
                                    .toString()
                                    .capitalize
                                    .toString(),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Subject ',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                controller.getSubject(),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Quiz ID',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                controller.getQuizId(),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Section',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                controller
                                    .getSection()
                                    .toString()
                                    .toUpperCase()
                                    .toString(),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Total Question',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                controller.getTotalQs().toString(),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Marks Per Question',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                controller.getMarksPerQs().toString(),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Total Marks',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                (controller.getTotalQs() *
                                        controller.getMarksPerQs())
                                    .toString(),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Semester',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                "${controller.getSemester()}th Semester",
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Duration',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                "${controller.getDuration()} mins",
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Created At',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                DateFormat('dd-MM-yyyy').format(
                                    DateTime.parse(controller.getCreatedAt())),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Status',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                        Card(
                          margin: const EdgeInsets.only(top: 4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              width: double.infinity,
                              child: Text(
                                controller
                                    .getStatus()
                                    .toString()
                                    .capitalizeFirst
                                    .toString(),
                                style: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        QuizElevatedButton(
                          label: const Text('Continue'),
                          backgroundColor: kTeacherPrimaryColor,
                          function: () {
                            //controller.navigateToQuizCreatePage();
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('How you want to add question?'),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  kTeacherPrimaryColor),
                                          onPressed: () {
                                            Get.back();
                                            controller
                                                .navigateToQuizCreatePage();
                                          },
                                          child: const Text('Manually')),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  kTeacherPrimaryColor),
                                          onPressed: () {
                                            Get.to(
                                              () => const Parsing(),
                                              arguments: [
                                                {
                                                  "code": controller
                                                      .getSubjectCode()
                                                },
                                                {
                                                  "quizID":
                                                      controller.getQuizId()
                                                },
                                              ],
                                            );
                                          },
                                          child: const Text('Using Excel')),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
