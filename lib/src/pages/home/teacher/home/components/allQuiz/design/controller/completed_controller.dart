import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quizzed/src/api/points.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';

import '../../../../../../../../global/shared.dart';
import '../../../../../../../../model/quiz_view_model.dart';

class CompletedQuizController extends GetxController {
  RxBool isFetching = true.obs;

  List<QuizViewModel> completedQuiz = [];
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  completedQuizFetch() async {
    try {
      quizDebugPrint(sharedPreferences.getString('Tcookie'));

      var response = await https.get(
        Uri.parse(ApiConfig.getEndPointsNextUrl(
            'quiz/getall?status=completed&page=1&limit=10')),
        headers: headers,
      );
      var decoded = jsonDecode(response.body);
      quizDebugPrint(decoded);
      completedQuiz.isNotEmpty ? completedQuiz.clear() : null;
      quizDebugPrint(decoded.toString().isEmpty.toString());
      for (var obj in decoded) {
        quizDebugPrint(obj.toString());
        completedQuiz.add(QuizViewModel.fromJson(obj));
      }
      quizDebugPrint('list----------');
      //print(completedQuiz);
      isFetching.value = false;
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }

  // refreshThisPage() {
  //   isFetching.value = true;
  //   Get.back();
  // }

  // handleMessage(var res) {
  //   if (res["message"].toString().contains('is now live') &&
  //       res["data"]["status"] == "live") {
  //     //refresh draft page
  //     //
  //     refreshThisPage();
  //   } else {
  //     Get.back();
  //     showSnackBar(res["message"], redColor, whiteColor);
  //   }
  // }

  // handlePublishButton(String quizId) async {
  //   try {
  //     var response = await https.put(
  //         Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/publish')),
  //         headers: headers,
  //         body: jsonEncode({"quiz_id": quizId}));
  //     var decode = jsonDecode(response.body);
  //     print(decode + "liveeeeeeeeeeeeeeeeeeeee");
  //     //  handleMessage(decode);
  //   } catch (e) {
  //     Get.back();
  //     showSnackBar(e.toString(), redColor, whiteColor);
  //   }
  // }
}
