// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzed/src/api/points.dart';
import 'package:quizzed/src/db/local/local_db.dart';
import 'package:quizzed/src/global/shared.dart';
import 'package:quizzed/src/model/result_model.dart';
import 'package:quizzed/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:http/http.dart' as https;
import 'package:quizzed/utils/marks_obtained.dart';
import '../../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../global/global.dart';

class QuizResultScreenController extends GetxController {
  TextEditingController quizID = TextEditingController();
  FocusNode quizIdfocus = FocusNode();
  RxBool isLoading = false.obs;
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Scookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };
  fetchResult() {
    if (quizID.text.isNotEmpty) {
      hitAndGetMark(quizID.text);
    } else {
      isLoading.value = false;
      showSnackBar('Quiz ID is empty', kQuizPrimaryColor, whiteColor);
    }
  }

  hitAndGetMark(String quizID) async {
    try {
      https.Response response = await https.get(
          Uri.parse(ApiConfig.getEndPointsNextUrl(
              'quiz/get-marks/$quizID?student_regdNo=${sharedPreferences.getString('regdNo')}')),
          headers: headers);
      quizDebugPrint('result is ${response.body}');
      var decode = jsonDecode(response.body);
      if (decode["statusCode"] == 401) {
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        LocalDB.removeLoacalDb();
        showSnackBar('Session Expired :(', redColor, whiteColor);
      } else if (decode["statusCode"] >= 400) {
        showSnackBar('${decode["message"]}', kTeacherPrimaryColor, whiteColor);
        isLoading.value = false;
      } else {
        ResultModal myresult = ResultModal.fromJson(jsonDecode(response.body));
        if (myresult != null) {
          showDialog(
              barrierDismissible: false,
              context: Get.context!,
              builder: ((context) => MarksObtained(
                    isComingFromResult: true,
                    resultModal: myresult,
                  )));
        } else {
          isLoading.value = false;
          showSnackBar('Please try again :(', redColor, whiteColor);
        }
        isLoading.value = false;
      }
    } catch (e) {
      showSnackBar(e, redColor, whiteColor);
    }
  }
}
