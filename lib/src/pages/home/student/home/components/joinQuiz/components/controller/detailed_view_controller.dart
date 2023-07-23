import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quizzed/src/api/points.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/model/joined_quiz.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';
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
        quizDebugPrint(
            'below is error causing line Unhandled Exception: type List<dynamic> is not a subtype of type Map<String, dynamic>');
        JoinedQuizModel model = JoinedQuizModel.fromJson(decode);
        quizDebugPrint('sending to quiz screen 80');
        Get.offAll(() => JoinQuizSessionScreen(model: model), arguments: [
          {'quizID': quizID}
        ]);
        isLoading.value = true;
      } catch (e) {
        quizDebugPrint('inside catch 90 and message is $e}');
        isLoading.value = true;
        showSnackBar("tap again..", redColor, whiteColor);
      }
    }
  }
}
