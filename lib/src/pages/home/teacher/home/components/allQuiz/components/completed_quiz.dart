import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/design/controller/completed_controller.dart';

import '../../../../../../../../theme/app_color.dart';
import '../../../../../../../../theme/gradient_theme.dart';
import '../design/completed_design.dart';

class CompletedQuizScreen extends GetView<CompletedQuizController> {
  const CompletedQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Get.put(CompletedQuizController());
    controller.completedQuizFetch();
    return Obx(
      () => controller.isFetching == true
          ? const Center(
              child: CircularProgressIndicator(
                color: whiteColor,
                backgroundColor: kTeacherPrimaryLightColor,
              ),
            )
          : controller.completedQuiz.isEmpty
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
                        'No Quiz in Completed mode',
                        style: kBodyText3Style()
                            .copyWith(color: kTeacherPrimaryColor),
                      ),
                    ),
                  ],
                )
              : //const Center()

              ListView.builder(
                  itemCount: controller.completedQuiz.length,
                  itemBuilder: ((context, index) => CompletedQuizDesign(
                        index: index,
                      )),
                ),
    );
  }
}
