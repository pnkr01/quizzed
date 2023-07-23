import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../theme/app_color.dart';
import '../../../../../../../../utils/quizAppBar.dart';
import 'controller/expanded_quiz_ontap_controller.dart';
import 'detailed_quiz_design.dart';

class ExpandQuizDetailsOnDemandScreen extends GetView<ExpadedQuizController> {
  const ExpandQuizDetailsOnDemandScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const QuizAppbar(
            appBarColor: kTeacherPrimaryColor,
            titleText: 'Quizzed',
            preferredSize: Size.fromHeight(57)),
        body: Obx(
          () => controller.isFetching.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kTeacherPrimaryColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Detailed Quiz',
                          style: kBodyText3Style().copyWith(
                              color: kTeacherPrimaryColor, fontSize: 14.sp),
                        ),
                      ),
                      Column(
                        children: List.generate(
                          controller.quizDetails.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DesignOnTapDetailsQuizComponent(
                                index: index,
                                model: controller.quizDetails[index]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
        ));
  }
}
