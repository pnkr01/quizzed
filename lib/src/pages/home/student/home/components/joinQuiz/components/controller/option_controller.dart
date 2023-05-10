import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/model/result_model.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/controller/join_quiz_session_controller.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/pages/home/student/home/student_home.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/completed_confirmation.dart';
import 'package:quiz/utils/marks_obtained.dart';
import '../../../../../../../../api/points.dart';
import '../../../../../../../../global/shared.dart';
import '../../../../../../../../model/joined_quiz.dart';

class OptionController extends GetxController {
  RxInt correctOptionValue = 10.obs;
  var controller = Get.find<JoinQuizSessionController>();
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Scookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };
  static Map<String, int> answerTrackBody = {};
  Map<String, Map<String, int>> body = {
    "questions_attempted_details": answerTrackBody,
  };

  getValue(questionId) {
    if (sharedPreferences.getInt(questionId) != null) {
      return prefs.getInt(questionId);
    } else {
      return 10;
    }
  }

  changePage(JoinedQuizModel model) {
    if (controller.currentIdx.value == (model.data!.questions!.length - 1)) {
      showDialog(
        context: Get.context!,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kTeacherPrimaryColor),
                onPressed: () {
                  quizDebugPrint('yes 50');
                  Get.find<JoinQuizSessionController>().stoptheTimer();
                  Get.offAllNamed(StudentHome.routeName);
                  //locally handling force stopping
                  sharedPreferences.setBool(controller.getQuizID(), true);
                  showDialog(
                      context: Get.context!,
                      builder: ((context) =>
                          const CompleteConfirmationDialog()));
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kTeacherPrimaryColor),
                onPressed: () {
                  Get.back();
                },
                child: const Text('No'),
              ),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: const BoxDecoration(
                      color: kTeacherPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: const Center(
                    child: Text(
                      'Are you sure to submit?',
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      controller.pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  hitAndGetMark(String quizID) async {
    try {
      https.Response response = await https.get(
          Uri.parse(ApiConfig.getEndPointsNextUrl(
              'quiz/get-marks/$quizID?student_regdNo=${sharedPreferences.getString('regdNo')}')),
          headers: headers);
      quizDebugPrint('reslt is ${response.body}');
      ResultModal myresult = ResultModal.fromJson(jsonDecode(response.body));
      Future.delayed(const Duration(seconds: 3), () {
        Get.back();
        showDialog(
            barrierColor: kQuizPrimaryColor,
            barrierDismissible: false,
            context: Get.context!,
            builder: ((context) => MarksObtained(
                  resultModal: myresult,
                )));
      });
    } catch (e) {
      showSnackBar(e, redColor, whiteColor);
    }
  }

  Future maintainAnswerApi(JoinedQuizModel model, int val) async {
    try {
      String key =
          model.data!.questions![controller.currentIdx.value].questionId!;
      quizDebugPrint('adding to trackmap');
      quizDebugPrint(
          'key is---$key \n current page is---${controller.currentIdx.value} \n value is--$val');
      answerTrackBody[key] = val;
      quizDebugPrint('current trackmap is\n $answerTrackBody');
      hitAnswerApi(model, val);
    } catch (e) {
      quizDebugPrint('inside error');
      //Get.offAll(StudentHome.routeName);
      showSnackBar(e, redColor, whiteColor);
    }
  }

  hitAnswerApi(JoinedQuizModel model, int val) async {
    https.Response response = await https.put(
      Uri.parse(ApiConfig.getEndPointsNextUrl(
          'quiz/update-progress/${model.data?.quizStats?.quizId}')),
      headers: headers,
      body: jsonEncode(body),
    );
    var decode = jsonDecode(response.body);
    showSnackBar(decode["message"], greenColor, whiteColor);
  }

  saveLocalAnswer(int val) {
    //  quizDebugPrint("${controller.currentIdx.value}----");
    // sharedPreferences.setInt(controller.currentIdx.value.toString(), val);
  }

  // clearAnswerDb(JoinedQuizModel model) {
  //   for (int i = 0; i < model.data!.questions!.length; i++) {
  //     sharedPreferences.remove(i.toString());
  //   }
  // }
}
