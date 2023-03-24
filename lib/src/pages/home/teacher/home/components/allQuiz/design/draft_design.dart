import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/controller/draft_quiz_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/utils/quizElevatedButon.dart';

import '../../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../../utils/loading_dialog.dart';

class QuizDraftViewDesign extends GetView<DraftQuizController> {
  const QuizDraftViewDesign({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    Get.put(DraftQuizController());
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: index == 0 ? null : const EdgeInsets.only(top: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Title : ',
                        style: kDesignSmallTextStyle(),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.draftList[index].title.toString().capitalizeFirst}",
                          maxLines: 1,
                          style: kDesignlargeTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text('QuizID : '),
                    Text(
                      controller.draftList[index].quizId.toString(),
                      style: kDesignlargeTextStyle(),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  'Description : ',
                  style: kDesignSmallTextStyle(),
                ),
                Expanded(
                  child: Text(
                    "${controller.draftList[index].description.toString().capitalize}",
                    maxLines: 1,
                    style: kDesignlargeTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.draftList[index].semester}th Sem',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  controller.draftList[index].section.toString(),
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  "${controller.draftList[index].duration} mins",
                  style: kDesignSmallTextStyle(),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.draftList[index].totalQuestions} questions',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  '${controller.draftList[index].subject}',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  "${controller.draftList[index].totalMarks} marks",
                  style: kDesignSmallTextStyle(),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              child: QuizElevatedButton(
                label: Text(
                  'Publish',
                  style: kBodyText6Style(),
                ),
                backgroundColor: kTeacherPrimaryLightColor,
                function: () {
                  showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          content: Text(
                            'Do you want to publish?',
                            style: kBodyText6Style()
                                .copyWith(color: kTeacherPrimaryColor),
                          ),
                          actions: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: QuizElevatedButton(
                                  label: Text(
                                    'Yes',
                                    style: kBodyText6Style(),
                                  ),
                                  backgroundColor: greenColor,
                                  function: () {
                                    log('yes');
                                    showDialog(
                                        context: Get.context!,
                                        builder: ((context) =>
                                            const LoadingDialog(
                                                message:
                                                    'Publishing.. Please wait')));
                                    controller.handlePublishButton(controller
                                        .draftList[index].quizId
                                        .toString());
                                  }),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: QuizElevatedButton(
                                  label: Text(
                                    'No',
                                    style: kBodyText6Style(),
                                  ),
                                  backgroundColor: kTeacherPrimaryLightColor,
                                  function: () {
                                    Get.back();
                                  }),
                            ),
                            const SizedBox(
                              height: 4,
                            )
                          ],
                        )),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 40,
              child: QuizElevatedButton(
                isBorderColorRequired: true,
                label: Text(
                  'Delete',
                  style:
                      kBodyText4Style().copyWith(color: redColor, fontSize: 14),
                ),
                backgroundColor: whiteColor,
                function: () {
                  showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          content: Text(
                            'Do you want to Delete?',
                            style: kBodyText6Style()
                                .copyWith(color: kTeacherPrimaryColor),
                          ),
                          actions: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: QuizElevatedButton(
                                  label: Text(
                                    'Yes',
                                    style: kBodyText6Style(),
                                  ),
                                  backgroundColor: greenColor,
                                  function: () {
                                    controller.handleDeleteButton(controller
                                        .draftList[index].quizId
                                        .toString());
                                  }),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: QuizElevatedButton(
                                  label: Text(
                                    'No',
                                    style: kBodyText6Style(),
                                  ),
                                  backgroundColor: kTeacherPrimaryLightColor,
                                  function: () {
                                    Get.back();
                                  }),
                            ),
                            const SizedBox(
                              height: 4,
                            )
                          ],
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
