import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:get/get.dart';
import 'package:quiz/src/db/local/local_db.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/model/option_model.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/controller/option_controller.dart';
import 'package:quiz/src/pages/home/student/home/student_home.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../../../utils/completed_confirmation.dart';
import '../../../../../../../../api/points.dart';
import '../../../../../../../../global/shared.dart';

class JoinQuizSessionController extends GetxController {
  dynamic argument = Get.arguments;
  final RxBool _isInForeground = true.obs;

  getQuizID() => argument[0]["quizID"];
  @override
  void onInit() {
    checkingForLiveQuiz();
    startLocalTimer();
    super.onInit();
  }

  RxDouble height = 460.0.obs;

  List<OptionModel> option = [];

  RxString getTime = '0 : 0'.obs;

  startLocalTimer() async {
    quizTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      try {
        quizDebugPrint('calling from 31');
        getRemainingTime();
      } catch (e) {
        stoptheTimer();
      }
    });
  }

  stoptheTimer() {
    quizDebugPrint('called to stop all timer');
    if (timer != null) {
      timer?.cancel();
    }
    if (quizTimer != null) {
      quizTimer?.cancel();
    }
  }

  Timer? timer;
  Timer? quizTimer;

  Future getRemainingTime() async {
    https.Response response = await https.get(
        Uri.parse(ApiConfig.getEndPointsNextUrl(
            'quiz/get-remaining-time/${getQuizID()}')),
        headers: headers);
    //quizDebugPrint('resmainig time is ${response.body}');
    var decode = jsonDecode(response.body);
    //quizDebugPrint(decode);
    //check for -5 time remaining then save the user and
    //cancel timer.
    quizDebugPrint('quiz timer');
    if (decode["remainingMinutes"] == 0 && decode["remainingSeconds"] <= 5) {
      stoptheTimer();
      Get.offAllNamed(StudentHome.routeName);
      showDialog(
          context: Get.context!,
          builder: ((context) => const CompleteConfirmationDialog()));
      stoptheTimer();
      //hit marks route.
    } else if (decode["remainingMinutes"] == null) {
      stoptheTimer();
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      showSnackBar('Session Expired :(', redColor, whiteColor);
      LocalDB.removeLoacalDb();
    }
    getTime.value =
        '${decode["remainingMinutes"]} : ${decode["remainingSeconds"] - 5}';
    return decode["remainingMinutes"];
  }

  checkingForLiveQuiz() async {
    try {
      timer = Timer.periodic(const Duration(seconds: 5), (_) async {
        quizDebugPrint('calling from 69');
        hitAndGetStatus();
        // if ((await getRemainingTime()) - 5 <= 5) {
        //   if (timer != null && quizTimer != null) {
        //     timer?.cancel();
        //     quizTimer?.cancel();
        //   }
        // }
        quizDebugPrint('printing');
      });
    } catch (e) {
      stoptheTimer();
    }
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie':
        'Authentication=${sharedPreferences.getString('Scookie') ?? sharedPreferences.getString('Tcookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  hitAndGetStatus() async {
    var response = await https.get(
        Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/${getQuizID()}')),
        headers: headers);
    var decode = jsonDecode(response.body);
    quizDebugPrint(
        'updating in every 5 sec current quiz status is ${decode["status"]}');
    quizDebugPrint(decode["quiz_id"]);
    // quizDebugPrint(getQuizID());
    if (decode["quiz_id"] != null) {
      if ((decode['status']) == 'completed') {
        stoptheTimer();
        Get.offAllNamed(StudentHome.routeName);
        showDialog(
            context: Get.context!,
            builder: ((context) => const CompleteConfirmationDialog()));
        stoptheTimer();
      }
    } else {
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      showSnackBar('session expired', redColor, whiteColor);
      LocalDB.removeLoacalDb();
      stoptheTimer();
    }
  }

  final PageController pageController = PageController();
  RxInt currentIdx = 0.obs;

  onPageChanged(newVal) {
    quizDebugPrint('chnaging page');
    Get.find<OptionController>().correctOptionValue.value = 10;
    //Get.find<OptionController>().;
    currentIdx.value = newVal;
  }
}
