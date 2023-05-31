import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/controller/live_quiz_controller.dart';
import 'package:quiz/theme/app_color.dart';

import '../../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../../utils/loading_dialog.dart';
import '../../../../../../../../utils/quizElevatedButon.dart';

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}',
  // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
};

class QuizLiveDesign extends GetView<LiveQuizController> {
  const QuizLiveDesign({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    Get.put(LiveQuizController());
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
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Title : ',
                        style: kDesignSmallTextStyle(),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.liveList[index].title.toString().capitalizeFirst}",
                          maxLines: 1,
                          style: kDesignlargeTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text('QuizID : '),
                    Text(
                      controller.liveList[index].quizId.toString(),
                      style: kDesignlargeTextStyle(),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  'Description : ',
                  style: kDesignSmallTextStyle(),
                ),
                Expanded(
                  child: Text(
                    "${controller.liveList[index].description.toString().capitalize}",
                    maxLines: 2,
                    style: kDesignlargeTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.liveList[index].semester}th Sem',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  controller.liveList[index].section.toString(),
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  "${controller.liveList[index].duration} mins",
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
                  '${controller.liveList[index].totalQuestions} questions',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  '${controller.liveList[index].subject}',
                  style: kDesignSmallTextStyle(),
                ),
                Text(
                  "${controller.liveList[index].totalMarks} marks",
                  style: kDesignSmallTextStyle(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // const Center(
            //         child: CircularProgressIndicator(
            //           strokeWidth: 1,
            //           color: whiteColor,
            //         ),
            //       )
            // Container(
            //   height: 40,
            //   width: double.infinity,
            //   decoration: const BoxDecoration(
            //       color: kTeacherPrimaryLightColor,
            //       borderRadius: BorderRadius.all(Radius.circular(8))),
            //   child: Center(
            //     child: FutureBuilder(
            //       future:
            //           controller.fetchData(controller.liveList[index].quizId),
            //       builder:
            //           (BuildContext context, AsyncSnapshot<void> snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           // Show a progress indicator while waiting for the API response
            //           return const CircularProgressIndicator();
            //         } else {
            //           // Calculate the total remaining seconds
            //           RxInt totalRemainingSeconds =
            //               (controller.remainingMinutes.value * 60 +
            //                       controller.remainingSeconds.value)
            //                   .obs;

            //           // Create a countdown timer that updates every second
            //           quizDebugPrint('again');
            //           Timer.periodic(const Duration(seconds: 1), (Timer t) {
            //             if (controller.isBack.value) {
            //               t.cancel();
            //             } else if (totalRemainingSeconds < 1) {
            //               // Stop the timer when the countdown is complete
            //               t.cancel();
            //             } else {
            //               quizDebugPrint('printing');
            //               totalRemainingSeconds.value--;
            //               controller.remainingMinutes.value =
            //                   totalRemainingSeconds.value ~/ 60;
            //               controller.remainingSeconds.value =
            //                   totalRemainingSeconds.value % 60;
            //               if (controller.isFinshedForcefully) {
            //                 t.cancel();
            //               }
            //             }
            //           });

            //           // Return a Text widget that displays the remaining time
            //           return Obx(() => Text(
            //                 '${controller.remainingMinutes.value.toString().padLeft(2, '0')} mins : ${controller.remainingSeconds.value.toString().padLeft(2, '0')} secs',
            //                 style: kBodyText0Style().copyWith(fontSize: 14),
            //               ));
            //         }
            //       },
            //     ),
            //   ),

            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: kTeacherPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child:
                      TimerWidget(quizID: controller.liveList[index].quizId!)),
            ),

            // Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         'Remaning Time : ',
            //         style: kBodyText0Style(),
            //       ),
            //       Flexible(
            //         child: Text(
            //           controller.remaingTime.value,
            //           style: kBodyText0Style(),
            //           softWrap: true,
            //         ),
            //       ),
            //     ],
            //   ),
            //),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 40,
              child: QuizElevatedButton(
                isBorderColorRequired: true,
                label: Text(
                  'Finish Now',
                  style: kBodyText1Style().copyWith(color: redColor),
                ),
                backgroundColor: whiteColor,
                function: () {
                  showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          content: Text(
                            'Do you want to finish the quiz?',
                            style: kBodyText6Style()
                                .copyWith(color: kTeacherPrimaryColor),
                          ),
                          actions: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: QuizElevatedButton(
                                  label: Text(
                                    'Yes',
                                    style: kBodyText6Style(),
                                  ),
                                  backgroundColor: greenColor,
                                  function: () {
                                    showDialog(
                                        context: Get.context!,
                                        builder: ((context) =>
                                            const LoadingDialog(
                                                message:
                                                    'Completing.. Please wait')));
                                    controller.handleCancelButton(
                                      controller.liveList[index].quizId
                                          .toString(),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: QuizElevatedButton(
                                  label: Text(
                                    'No',
                                    style: kBodyText6Style(),
                                  ),
                                  backgroundColor: kTeacherPrimaryLightColor,
                                  function: () {
                                    Get.back();
                                  }),
                            ),
                            const SizedBox(
                              height: 4,
                            )
                          ],
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  final String quizID;
  const TimerWidget({
    Key? key,
    required this.quizID,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int remainingTime = 0;
  Timer? timer;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    fetchRemainingTime(widget.quizID);
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
    quizDebugPrint('dispoing');
  }

  void fetchRemainingTime(quizID) async {
    // Make an API call to retrieve remaining time
    var response = await http.get(
        Uri.parse(
            ApiConfig.getEndPointsNextUrl('quiz/get-remaining-time/$quizID')),
        headers: headers);
    if (response.statusCode == 200) {
      var decodeTime = jsonDecode(response.body);
      setState(() {
        quizDebugPrint('min is ----${decodeTime['remainingMinutes']}');
        remainingTime = decodeTime['remainingMinutes'] * 60 +
            decodeTime['remainingSeconds'];
        isloading = !isloading;
      });
      startTimer();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
          quizDebugPrint(remainingTime);
        } else {
          var liveQuizController = Get.find<LiveQuizController>();
          liveQuizController.isFetching.value = true;
          liveQuizController.fetchLiveQuiz();
          timer?.cancel();
        }
      });
    });
  }

  String formatTime(int time) {
    int minutes = (time ~/ 60);
    int seconds = time % 60;
    return '${minutes.toString().padLeft(2, '0')} min : ${seconds.toString().padLeft(2, '0')} sec';
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1,
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              formatTime(remainingTime),
              style: const TextStyle(fontSize: 18, color: whiteColor),
            ),
          );
  }
}
