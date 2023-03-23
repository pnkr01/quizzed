import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/controller/option_controller.dart';
import 'package:quiz/src/pages/home/student/home/student_home.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../../api/points.dart';
import '../../../../../../../../global/shared.dart';

class JoinQuizSessionController extends GetxController {
  dynamic argument = Get.arguments;

  getQuizID() => argument[0]["quizID"];
  @override
  void onInit() {
    checkingForLiveQuiz();
    super.onInit();
  }

  Timer? timer;

  checkingForLiveQuiz() async {
    try {
      timer = Timer.periodic(const Duration(seconds: 5), (_) {
        hitAndGetStatus();
        quizDebugPrint('printing');
      });
    } catch (e) {
      timer?.cancel();
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
        Get.offAll(() => const StudentHome());
        showSnackBar('Quiz is Completed', greenColor, whiteColor);
        timer?.cancel();
      }
    } else {
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      showSnackBar('session expired', redColor, whiteColor);
      timer?.cancel();
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
