import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:quiz/src/model/quiz_detailed_join_model.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/detailed/detailed_quiz_helper.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';
import '../controller/detailed_view_controller.dart';

class DetailedQuizViewScreen extends GetView<DetailedQuizController> {
  const DetailedQuizViewScreen({
    super.key,
    required this.model,
  });

  final DetailedQuizJoinModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const QuizAppbar(
          appBarColor: kQuizPrimaryColor,
          titleText: 'Quizzed',
          preferredSize: Size.fromHeight(56),
        ),
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward ||
                notification.direction == ScrollDirection.reverse) {
              controller.isSrolling.value = true;
            }
            return true;
          },
          child: Column(
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  elevation: 5,
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 0, 4, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          const DetailedQuizHelper(
                            title: 'Attention',
                            subtitle:
                                'Please do not press home button or open any other app while using this app, otherwise your quiz will be force submitted and you will not get second chance',
                          ),
                          DetailedQuizHelper(
                              title: 'Title', subtitle: '${model.title}'),
                          DetailedQuizHelper(
                              title: 'Description',
                              subtitle: '${model.description}'),
                          DetailedQuizHelper(
                              title: 'QuizID ', subtitle: '${model.quizID}'),
                          DetailedQuizHelper(
                              title: 'Conducted By',
                              subtitle: '${model.conductedBy}'),
                          DetailedQuizHelper(
                              title: 'Subject Code',
                              subtitle: '${model.subjectCode}'),
                          DetailedQuizHelper(
                              title: 'Section',
                              subtitle: '${model.forSection}'),
                          DetailedQuizHelper(
                              title: 'Branch', subtitle: '${model.forBranch}'),
                          DetailedQuizHelper(
                            title: 'Semester',
                            subtitle: '${model.forSemester} Semester',
                          ),
                          DetailedQuizHelper(
                              title: 'Total Question',
                              subtitle: '${model.totalQuestion}'),
                          DetailedQuizHelper(
                              title: 'Title', subtitle: '${model.title}'),
                          DetailedQuizHelper(
                            title: 'Per Question Marks',
                            subtitle: '${model.perQsMarks}',
                          ),
                          DetailedQuizHelper(
                            title: 'Total Marks',
                            subtitle: '${model.totalMarks}',
                          ),
                          DetailedQuizHelper(
                            title: 'Quiz Duration',
                            subtitle: '${model.quizDuration} mins',
                          ),
                          if (model.totalAppearedStudent! > 0)
                            DetailedQuizHelper(
                              title: 'Joined Student',
                              subtitle:
                                  '${model.totalAppearedStudent}+ student',
                            ),
                          DetailedQuizHelper(
                            title: 'Quiz Status',
                            subtitle:
                                '${model.quizStatus.toString().capitalizeFirst}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Obx(
          () => Material(
            shape: const CircleBorder(side: BorderSide.none),
            elevation: 4,
            child: Visibility(
              visible: controller.isSrolling.value,
              child: FloatingActionButton(
                backgroundColor: kQuizLightPrimaryColor,
                onPressed: () async {
                  //make student mobile on dnd
                  //if dnd then allow  to give exam otherwise dont allow
                  if (await FlutterDnd.isNotificationPolicyAccessGranted ==
                      true) {
                    //test dnd
                    bool? isEnabled = await FlutterDnd.setInterruptionFilter(
                        FlutterDnd
                            .INTERRUPTION_FILTER_NONE); // Turn on DND - All notifications are suppressed.
                    if (isEnabled == true && isEnabled != null) {
                      controller.isLoading.value = false;
                      controller.joinQuizInit(model.quizID!);
                    }
                  } else {
                    FlutterDnd.gotoPolicySettings();
                  }
                },
                child: Center(
                  child: controller.isLoading.value == true
                      ? const Icon(Icons.arrow_forward_ios)
                      : const CircularProgressIndicator(
                          strokeWidth: 1,
                          color: whiteColor,
                        ),
                ),
              ),
            ),
          ),
        )

        // SizedBox(
        //   width: double.infinity,
        //   height: 50,
        //   child: Visibility(
        //     visible: controller.isSrolling.value,
        //     child:

        //     ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //           shape: const RoundedRectangleBorder(

        //               //borderRadius: BorderRadius.circular(12), // <-- Radius
        //               ),
        //           backgroundColor: kQuizLightPrimaryColor,
        //         ),
        //         onPressed: () {
        // controller.isLoading.value = false;
        // controller.joinQuizInit(model.quizID!);
        //         },
        //         child: Obx(() => controller.isLoading.value == true
        //             ? Text(
        //                 'Join Quiz',
        //                 style: kBodyText3Style(),
        //               )
        //             : const Center(
        //                 child: CircularProgressIndicator(
        //                   color: whiteColor,
        //                   strokeWidth: 1,
        //                   backgroundColor: kTeacherPrimaryLightColor,
        //                 ),
        //               ))),
        //   ),
        // ),
        );
  }
}
