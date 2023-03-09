import 'dart:convert';
import 'dart:developer';
import 'package:quiz/src/global/my_global.dart' as globals;
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../global/shared.dart';
import '../../../../../../../model/quiz_view_model.dart';
import '../design/controller/completed_controller.dart';

class LiveQuizController extends GetxController {
  RxBool isFetching = true.obs;
  //RxBool isFetchingTime = true.obs;

  //final int _current = 10;

  // void startTimer(end) {
  //   CountdownTimer(
  //     endTime: end,
  //     widgetBuilder: (context, time) =>
  //         Text(time!.hours.toString() + time.sec.toString()),
  //     onEnd: () => print('completed'),
  //   );
  // }

  List<QuizViewModel> liveList = [];
  List time = [];
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  getRemaningTime(String quizID) async {
    var res = await https.get(
        Uri.parse(
            ApiConfig.getEndPointsNextUrl('quiz/get-remaining-time/$quizID')),
        headers: headers);
    var decodeTime = jsonDecode(res.body);
    time.add(
        decodeTime["remainingMinutes"] * 60 + decodeTime["remainingSeconds"]);
  }

  handleCancelButton(String quizId) async {
    try {
      var response = await https.put(
        Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/end-quiz/$quizId')),
        headers: headers,
      );
      var decode = jsonDecode(response.body);
      Get.back();
      print(decode);
      handleSendToLiveMessage(decode);
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }

  handleSendToLiveMessage(var res) {
    if (res["message"].toString().contains('Quiz ended by the teacher')) {
      //refresh draft page
      //
      refreshToCompletedPage();
      showSnackBar(res["message"].toString(), greenColor, whiteColor);
    } else {
      Get.back();
      showSnackBar(res["message"], redColor, whiteColor);
    }
  }

  fetchLiveQuiz() async {
    try {
      print(sharedPreferences.getString('Tcookie'));

      var response = await https.get(
        Uri.parse(ApiConfig.getEndPointsNextUrl(
            'quiz/getall?status=live&page=1&limit=10')),
        headers: headers,
      );
      var decoded = jsonDecode(response.body);
      // print(decoded);
      liveList.isNotEmpty ? liveList.clear() : null;
      log(decoded.toString().isEmpty.toString());
      for (var obj in decoded) {
        log(obj.toString());
        liveList.add(QuizViewModel.fromJson(obj));
      }
      print('list----------');
      // print(liveList);
      isFetching.value = false;
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }

  refreshToCompletedPage() async {
    Get.back();
    await Get.find<CompletedQuizController>().completedQuizFetch();
    globals.tabController.animateTo(2);
    liveList.clear();
  }
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
