import 'dart:convert';

import 'package:quiz/src/db/local/local_db.dart';
import 'package:quiz/src/global/my_global.dart' as globals;
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/controller/live_quiz_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../global/shared.dart';
import '../../../../../../../model/quiz_view_model.dart';

class DraftQuizController extends GetxController {
  RxBool isFetching = true.obs;
  RxBool isPublishing = false.obs;

  List<QuizViewModel> draftList = [];
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  fetchDraftQuiz() async {
    try {
      print(sharedPreferences.getString('Tcookie'));

      var response = await https.get(
        Uri.parse(ApiConfig.getEndPointsNextUrl(
            'quiz/getall?status=draft&page=1&limit=10')),
        headers: headers,
      );
      var decoded = jsonDecode(response.body);
      quizDebugPrint(decoded.toString());
      draftList.isNotEmpty ? draftList.clear() : null;
      int len = decoded.length;
      quizDebugPrint('length is $len');
      int i;
      for (i = 0; i < len; i++) {
        draftList.add(QuizViewModel.fromJson(decoded[i]));
      }
      print('list----------${draftList.length}');
      // print(draftList[0]);
      if (i == len) {
        isFetching.value = false;
      }
    } catch (e) {
      print('Session expired');
      LocalDB.removeLoacalDb();
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      showSnackBar("Session Expired :(", redColor, whiteColor);
    }
  }

  refreshThisPage() async {
    isPublishing.value = false;
    await Get.find<LiveQuizController>().fetchLiveQuiz();
    globals.tabController.animateTo(1);
    draftList.clear();
  }

  handleMessage(var res) {
    if (res["message"].toString().contains('is now live') &&
        res["data"]["status"] == "live") {
      //refresh draft page
      //
      Get.back();
      quizDebugPrint('refreshing--------------');
      refreshThisPage();
    } else {
      Get.back();
      quizDebugPrint('72');
      showSnackBar(res["message"], redColor, whiteColor);
    }
  }

  handlePublishButton(String quizId) async {
    try {
      var response = await https.put(
          Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/publish')),
          headers: headers,
          body: jsonEncode({"quiz_id": quizId}));
      var decode = jsonDecode(response.body);
      print(decode);
      handleMessage(decode);
    } catch (e) {
      isPublishing.value = false;
      Get.until((route) => route.isFirst);
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }

  handleDeleteButton(String quizId) async {
    try {
      var response = await https.delete(
        Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/$quizId')),
        headers: headers,
      );
      var decode = jsonDecode(response.body);
      print(decode);
      Get.back();
      Get.back();
      showSnackBar('Deleted :)', redColor, whiteColor);
      isFetching.value = true;
      fetchDraftQuiz();
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }
}
