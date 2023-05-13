import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/join_quiz_controller.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../theme/app_color.dart';

class JoinQuizView extends GetView<JoinQuizCOntroller> {
  const JoinQuizView({super.key});
  static const String routeName = '/studentJoinQuiz';

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<JoinQuizCOntroller>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: SizedBox(
        height: 70,
        width: double.infinity,
        child: Container(
            color: kTeacherPrimaryColor,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kTeacherPrimaryColor,
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Back',
                  style: kElevatedButtonTextStyle().copyWith(
                    color: whiteColor,
                  ),
                ))),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
            color: Colors.white10,
          )),
          Positioned(
            top: 0,
            bottom: 600,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(color: kTeacherPrimaryColor),
            ),
          ),
          Positioned(
            top: 100,
            bottom: 480,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Enter quiz code',
                          style: kBodyText1Style().copyWith(color: blackColor),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFFf9f9f9),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: controller.quizID,
                                cursorColor: kQuizPrimaryColor,
                                decoration: const InputDecoration(
                                  hintText: 'e.g SOA1234',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    color: kTeacherPrimaryColor,
                                  )),
                                ),
                              )),
                              const SizedBox(width: 8),
                              Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: kTeacherPrimaryColor,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    controller.isTapStartJoining.value = true;
                                    controller.checkEmptyFilled();
                                  },
                                  child: Obx(
                                    () => !controller.showLoading
                                        ? Text(
                                            'Join',
                                            style: kElevatedButtonTextStyle()
                                                .copyWith(
                                              color: whiteColor,
                                            ),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(
                                              color: whiteColor,
                                              strokeWidth: 1,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
