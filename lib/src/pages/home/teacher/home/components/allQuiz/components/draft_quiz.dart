import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/controller/draft_quiz_controller.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/design/draft_design.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

class DraftQuizScreen extends GetView<DraftQuizController> {
  const DraftQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Get.put(() => DraftQuizController());
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
          : controller.draftList.isEmpty
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
                        'No Quiz in Draft mode',
                        style: kBodyText3Style()
                            .copyWith(color: kTeacherPrimaryColor),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: controller.draftList.length,
                  itemBuilder: ((context, index) => QuizDraftViewDesign(
                        index: index,
                      )),
                ),
    );
  }
}
