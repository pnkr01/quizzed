import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/model/result_model.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/utils/errordialog.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/utils/marks_obtained.dart';

import '../../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../global/global.dart';

class QuizResultScreenController extends GetxController {
  TextEditingController quizID = TextEditingController();
  RxBool isLoading = false.obs;
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Scookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };
  fetchResult() {
    if (quizID.value.text.isNotEmpty) {
      hitAndGetMark(quizID.value.text);
    } else {
      showDialog(
          context: Get.context!,
          builder: ((context) =>
              const ErrorDialog(message: 'Quiz ID is empty')));
    }
  }

  hitAndGetMark(String quizID) async {
    try {
      https.Response response = await https.get(
          Uri.parse(ApiConfig.getEndPointsNextUrl(
              'quiz/get-marks/$quizID?student_regdNo=${sharedPreferences.getString('regdNo')}')),
          headers: headers);
      quizDebugPrint('reslt is ${response.body}');
      var decode = jsonDecode(response.body);
      if (decode["statusCode"] >= 400) {
        showSnackBar('${decode["message"]}', redColor, whiteColor);
        isLoading.value = false;
      } else {
        ResultModal myresult = ResultModal.fromJson(jsonDecode(response.body));
        Future.delayed(const Duration(seconds: 3), () {
          Get.back();

          showDialog(
              barrierColor: kQuizPrimaryColor,
              barrierDismissible: false,
              context: Get.context!,
              builder: ((context) => MarksObtained(
                    isComingFromResult: true,
                    resultModal: myresult,
                  )));
        });
      }
    } catch (e) {
      showSnackBar(e, redColor, whiteColor);
    }
  }
}
