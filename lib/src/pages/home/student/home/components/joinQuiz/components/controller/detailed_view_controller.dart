import 'dart:convert';
import 'dart:developer';

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
      isLoading.value = false;
      hitJoinApi(quizID);
    } catch (e) {
      log('catch');
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
    quizDebugPrint(response.statusCode);
    if (decode["statusCode"] >= 400) {
      log('401');
      isLoading.value = true;
      showSnackBar(decode["message"], redColor, whiteColor);
    } else if (decode["statusCode"] == 200) {
      //  print(decode);
      try {
        quizDebugPrint(decode);
        JoinedQuizModel model = JoinedQuizModel.fromJson(decode);
        quizDebugPrint('model is $model');
        quizDebugPrint('sending to quiz session');
        Get.off(() => JoinQuizSessionScreen(model: model), arguments: [
          {'quizID': quizID}
        ]);
        isLoading.value = true;
      } on FormatException {
        isLoading.value = true;
        showSnackBar(decode["message"], redColor, whiteColor);
      } catch (e) {
        isLoading.value = true;
        showSnackBar(decode["message"], redColor, whiteColor);
      }
    }
  }

  //fillQuizList(var list) {}

  navigateToQuizSessionScreen(String quizID, JoinedQuizModel model) {
    if (model != null) {
      Get.off(() => JoinQuizSessionScreen(model: model), arguments: [
        {'quizID': quizID}
      ]);
      isLoading.value = true;
    } else {
      navigateToQuizSessionScreen(quizID, model);
    }
  }
}
