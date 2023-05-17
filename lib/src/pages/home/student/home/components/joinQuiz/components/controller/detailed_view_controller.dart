import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/model/joined_quiz.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../../global/shared.dart';
import '../join/join_quiz.dart';

class DetailedQuizController extends GetxController {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1), () {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
      isSrolling.value = !isSrolling.value;
    });
    super.onInit();
  }

  RxBool isLoading = true.obs;
  RxBool isSrolling = false.obs;
  late JoinedQuizModel model;

  List<JoinedQuizModel> joinModelList = [];

  joinQuizInit(String quizID) async {
    try {
      quizDebugPrint('inside joinQuizInit 45 detailed_view_controller.dart');
      isLoading.value = false;
      hitJoinApi(quizID);
    } catch (e) {
      quizDebugPrint('inside catch 48 detailed_view_controller.dart');
      isLoading.value = true;
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Scookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  hitJoinApi(String quizID) async {
    var response = await https.get(
        Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/join/$quizID')),
        headers: headers);
    var decode = jsonDecode(response.body);
    quizDebugPrint('$decode 66 detailed_view_controller.dart');
    if (decode["statusCode"] >= 400) {
      quizDebugPrint(
          'the status code is ${decode["statusCode"]} and message is ${decode["message"]} 69 detailed_view_controller.dart');
      isLoading.value = true;
      showSnackBar(decode["message"], redColor, whiteColor);
    } else if (decode["statusCode"] == 200) {
      quizDebugPrint(
          'the status code is ${decode["statusCode"]} and message is $decode 74 detailed_view_controller.dart');
      //  print(decode);
      try {
        quizDebugPrint('inside trying 77 $decode trying 78');
        JoinedQuizModel model = JoinedQuizModel.fromJson(decode);
        quizDebugPrint('get model is $model');
        quizDebugPrint('sending to quiz screen 80');
        Get.offAll(() => JoinQuizSessionScreen(model: model), arguments: [
          {'quizID': quizID}
        ]);
        isLoading.value = true;
      } on FormatException {
        quizDebugPrint('inside fe 86 and message is ${decode["message"]}');
        isLoading.value = true;
        showSnackBar(decode["message"], redColor, whiteColor);
      } catch (e) {
        quizDebugPrint('inside catch 90 and message is ${decode["message"]}');
        isLoading.value = true;
        showSnackBar(decode["message"], redColor, whiteColor);
      }
    }
  }
}
