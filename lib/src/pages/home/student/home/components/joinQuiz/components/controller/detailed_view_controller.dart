import 'dart:convert';
import 'dart:developer';

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
  RxBool isLoading = true.obs;
  RxBool isSrolling = false.obs;

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
        joinModelList.isEmpty ? joinModelList.clear() : null;
        joinModelList.add(JoinedQuizModel.fromJson(decode));
        quizDebugPrint(joinModelList);
      } on FormatException {
        isLoading.value = true;
        showSnackBar(decode["message"], redColor, whiteColor);
      } catch (e) {
        isLoading.value = true;
        showSnackBar(decode["message"], redColor, whiteColor);
      }
      isLoading.value = true;
      quizDebugPrint('sending to quiz session');
      navigateToQuizSessionScreen();
    }
  }

  //fillQuizList(var list) {}

  navigateToQuizSessionScreen() {
    Get.off(() => JoinQuizSessionScreen(model: joinModelList[0]), arguments: [
      {'quizID': joinModelList[0].data?.quizStats?.quizId}
    ]);
  }
}
