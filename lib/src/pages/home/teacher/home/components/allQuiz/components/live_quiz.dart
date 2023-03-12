import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/design/live_design.dart';

import '../../../../../../../../theme/app_color.dart';
import '../../../../../../../../theme/gradient_theme.dart';
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
          : controller.liveList.isEmpty
              ? Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CachedNetworkImage(
                        imageUrl:
                            'https://img.freepik.com/free-vector/thoughtful-woman-with-laptop-looking-big-question-mark_1150-39362.jpg?w=740&t=st=1678360691~exp=1678361291~hmac=c8de1e2e64e16f9461119048a6a774fd33817aca9c5cd9246ad3ae80ee043365'),
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
