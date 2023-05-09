import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/controller/draft_quiz_controller.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/design/draft_design.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../../utils/shimmer.dart';
import '../design/on_tap_show_details.dart';

class DraftQuizScreen extends GetView<DraftQuizController> {
  const DraftQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(() => DraftQuizController());
    Get.find<DraftQuizController>().isFetching.value = true;
    Get.find<DraftQuizController>().fetchDraftQuiz();
    return Obx(
      () => controller.isFetching == true
          ? const Center(
              child: CircularProgressIndicator(
                color: whiteColor,
                backgroundColor: kTeacherPrimaryLightColor,
              ),
            )
          // ignore: prefer_is_empty
          : controller.draftList.length == 0
              ? Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CachedNetworkImage(
                        placeholder: (context, url) => const NewsCardSkelton(),
                        imageUrl:
                            'https://img.freepik.com/free-vector/website-faq-section-user-help-desk-customer-support-frequently-asked-questions-problem-solution-quiz-game-confused-man-cartoon-character_335657-1602.jpg?w=740&t=st=1683641654~exp=1683642254~hmac=6fb298e31fca7ba3e989ad11aa23195b89917565facf99721d7bda0a2ce20ee1'),
                    Center(
                      child: Text(
                        'No Quiz in Draft mode',
                        style: kBodyText3Style()
                            .copyWith(color: kTeacherPrimaryColor),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: controller.draftList.length,
                  itemBuilder: ((context, index) => GestureDetector(
                        onTap: () => Get.to(
                            () => const ExpandQuizDetailsOnDemandScreen(),
                            arguments: [
                              {
                                'quizID': controller.draftList[index].quizId!,
                              }
                            ]),
                        child: QuizDraftViewDesign(
                          index: index,
                        ),
                      )),
                ),
    );
  }
}
