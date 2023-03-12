import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/controller/live_quiz_controller.dart';
import 'package:quiz/theme/app_color.dart';

import '../../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../../utils/loading_dialog.dart';
import '../../../../../../../../utils/quizElevatedButon.dart';

class QuizLiveDesign extends GetView<LiveQuizController> {
  const QuizLiveDesign({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    Get.put(LiveQuizController());
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
                          "${controller.liveList[index].title.toString().capitalizeFirst}",
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
                      "${controller.liveList[index].quizId.toString().capitalizeFirst}",
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
                    "${controller.liveList[index].description.toString().capitalize}",
                    maxLines: 2,
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
                  '${controller.liveList[index].semester}th Sem',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  controller.liveList[index].section.toString(),
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  "${controller.liveList[index].duration} mins",
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
                  '${controller.liveList[index].totalQuestions} questions',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  '${controller.liveList[index].subject}',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  "${controller.liveList[index].totalMarks} marks",
                  style: kDesignSmallTextStyle(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: kTeacherPrimaryLightColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Remaning Time : ',
                    style: kBodyText1Style(),
                  ),
                  Text(
                    "${controller.liveList[index].duration} mins",
                    style: kBodyText1Style(),
                  )
                ],
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
                  'Finish Now',
                  style: kBodyText1Style().copyWith(color: redColor),
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
                            'Do you want to finish the quiz?',
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
                                    showDialog(
                                        context: Get.context!,
                                        builder: ((context) =>
                                            const LoadingDialog(
                                                message:
                                                    'Completing.. Please wait')));
                                    controller.handleCancelButton(
                                      controller.liveList[index].quizId
                                          .toString(),
                                    );
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
