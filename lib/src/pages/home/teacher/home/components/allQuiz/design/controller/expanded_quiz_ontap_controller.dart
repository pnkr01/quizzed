import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quizzed/src/api/points.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/model/quiz_details.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import '../../../../../../../../global/shared.dart';

class ExpadedQuizController extends GetxController {
  RxBool isFetching = true.obs;
  dynamic argumentData = Get.arguments;

  getQuizID() => argumentData[0]['quizID'] ?? "";

  @override
  void onInit() {
    fetchLiveQuizDetails();
    super.onInit();
  }

  List<QuizDeatilsModel> quizDetails = [];

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  fetchLiveQuizDetails() async {
    quizDebugPrint(getQuizID());
    var response = await https.get(
      Uri.parse(ApiConfig.getEndPointsNextUrl(
          'quiz/${getQuizID()}/get-all-questions')),
      headers: headers,
    );
    var decoded = jsonDecode(response.body);
    quizDebugPrint(decoded);
    try {
      quizDetails.isNotEmpty ? quizDetails.clear() : null;
      for (var obj in decoded) {
        quizDetails.add(QuizDeatilsModel.fromJson(obj));
      }
      quizDebugPrint('done');
      isFetching.value = false;
    } catch (e) {
      isFetching.value = false;
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }
}
