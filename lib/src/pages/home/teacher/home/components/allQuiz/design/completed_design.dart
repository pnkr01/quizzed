import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/design/controller/completed_controller.dart';
import 'package:quiz/theme/app_color.dart';

import '../../../../../../../../theme/gradient_theme.dart';

class CompletedQuizDesign extends GetView<CompletedQuizController> {
  const CompletedQuizDesign({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    Get.put(CompletedQuizController());
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
                Text(
                  'Title : ',
                  style: kDesignSmallTextStyle(),
                ),
                Expanded(
                  child: Text(
                    "${controller.completedQuiz[index].title.toString().capitalizeFirst}",
                    maxLines: 1,
                    style: kDesignlargeTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'Description : ',
                  style: kDesignSmallTextStyle(),
                ),
                Expanded(
                  child: Text(
                    "${controller.completedQuiz[index].description.toString().capitalize}",
                    maxLines: 1,
                    style: kDesignlargeTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.completedQuiz[index].semester}th Sem',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  controller.completedQuiz[index].section.toString(),
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  "${controller.completedQuiz[index].duration} mins",
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
                  '${controller.completedQuiz[index].totalQuestions} questions',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  '${controller.completedQuiz[index].subject}',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  "${controller.completedQuiz[index].totalMarks} marks",
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
                  color: greenColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                  child: Text("Completed", style: kBodyText1Style())),
            )
          ],
        ),
      ),
    );
  }
}
