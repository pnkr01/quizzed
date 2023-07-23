import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzed/src/pages/home/teacher/home/components/allQuiz/design/live_design.dart';

import '../../../../../../../../theme/app_color.dart';
import '../../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../../utils/shimmer.dart';
import '../controller/live_quiz_controller.dart';
import '../design/on_tap_show_details.dart';

class LiveQuizScreen extends GetView<LiveQuizController> {
  const LiveQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Get.put(LiveQuizController());
    Get.find<LiveQuizController>().isFetching.value = true;
    Get.find<LiveQuizController>().fetchLiveQuiz();
    return Obx(
      () => controller.isFetching == true
          ? const Center(
              child: CircularProgressIndicator(
                color: whiteColor,
                backgroundColor: kTeacherPrimaryLightColor,
              ),
            )
          // ignore: prefer_is_empty
          : controller.liveList.length == 0
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
                        'No Quiz in Live mode',
                        style: kBodyText3Style()
                            .copyWith(color: kTeacherPrimaryColor),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: controller.liveList.length,
                  itemBuilder: ((context, index) => GestureDetector(
                        onTap: () => Get.to(
                            () => const ExpandQuizDetailsOnDemandScreen(),
                            arguments: [
                              {
                                'quizID': controller.liveList[index].quizId!,
                              }
                            ]),
                        child: QuizLiveDesign(
                          index: index,
                        ),
                      )),
                ),
    );
  }
}
