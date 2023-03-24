import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz/src/model/joined_quiz.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/controller/join_quiz_session_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';

import '../../../../../../../../../utils/quizElevatedButon.dart';
import 'design/join_quiz_design.dart';

class JoinQuizSessionScreen extends GetView<JoinQuizSessionController> {
  static String routeName = '/joinQuiz';
  const JoinQuizSessionScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  final JoinedQuizModel model;

  @override
  Widget build(BuildContext context) {
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
                style: kBodyText2Style().copyWith(color: kQuizPrimaryColor),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Do you want to leave this quiz? Its not completed yet :)',
                style: kBodyText3Style().copyWith(color: kQuizPrimaryColor),
              ),
              const SizedBox(height: 15.0),
              QuizElevatedButton(
                  label: const Text('Yes Leave :)'),
                  backgroundColor: kQuizPrimaryColor,
                  function: () async {
                    Get.back();
                    Get.back();
                    controller.timer?.cancel();
                  }),
              const SizedBox(height: 8.0),
              QuizElevatedButton(
                  label: const Text('No'),
                  backgroundColor: kQuizPrimaryColor,
                  function: () {
                    log('Cancel');
                    Get.back();
                  })
            ],
          ),
        ),
      ),
      child: Scaffold(
        bottomSheet: BottomSheet(
            backgroundColor: kQuizLightPrimaryColor,
            onClosing: () {},
            builder: ((context) => Container(
                  color: kQuizLightPrimaryColor,
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 224, 119, 189),
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        print(
                            'current${controller.currentIdx.value} ${model.data?.questions?.length} m');
                        if (controller.currentIdx.value ==
                            (model.data!.questions!.length - 1)) {
                          log('last qs');
                          log('submit qs screen');
                        } else {
                          controller.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                      },
                      child: Obx(
                        () => controller.currentIdx.value ==
                                model.data!.questions!.length - 1
                            ? Text(
                                'Submit',
                                style: kBodyText11Style(),
                              )
                            : Text(
                                'Continue',
                                style: kBodyText11Style(),
                              ),
                      )),
                ))),
        backgroundColor: kQuizPrimaryColor,
        appBar: QuizAppbar(
          leading: const SizedBox(),
          appBarColor: kQuizPrimaryColor,
          titleText: 'Quizzed',
          preferredSize: const Size.fromHeight(56),
          tariling: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Obx(() => Center(
                    child: Text(
                      controller.getTime.value,
                      style: kDesignSmallTextStyle(),
                    ),
                  )),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Card(
                color: kQuizLightPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'QuizID : ',
                            style: kBodyText11Style(),
                          ),
                          Text(
                            '${model.data?.quizStats?.quizId}',
                            style: kBodyText11Style(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            'Regd No : ',
                            style: kBodyText11Style(),
                          ),
                          Text(
                            '${model.data?.quizStats?.studentRegdNo}',
                            style: kBodyText11Style(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Card(
                  elevation: 50,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  color: kQuizLightPrimaryColor,
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: model.data?.questions?.length,
                    onPageChanged: ((value) => controller.onPageChanged(value)),
                    itemBuilder: ((context, index) => JoinQuizDesign(
                          index: index,
                          model: model,
                          questionLength: model.data!.questions!.length,
                          options: model.data!.questions![index].options!,
                          questionString:
                              model.data!.questions![index].questionStr!,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
