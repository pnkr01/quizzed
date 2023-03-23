import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/db/local/local_db.dart';
import 'package:quiz/src/model/quiz_detailed_join_model.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';

import '../../../../../../../../theme/app_color.dart';
import '../../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../global/global.dart';
import '../../../../../../../global/shared.dart';
import 'detailed/detailed_quiz_view.dart';

class JoinQuizCOntroller extends GetxController {
  late Rx<TextEditingController> quizID;
  RxBool isTapStartJoining = false.obs;

  List<DetailedQuizJoinModel> currentQuiz = [];

  bool get showLoading => isTapStartJoining.value;
  @override
  void onInit() {
    quizID = TextEditingController().obs;
    super.onInit();
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Scookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  navigateToDetailedPage() {
    Get.to(() => DetailedQuizViewScreen(model: currentQuiz[0]));
    isTapStartJoining.value = false;
  }

  checkEmptyFilled() {
    if (quizID.value.text.isNotEmpty) {
      checkThisQuizID();
    } else {
      isTapStartJoining.value = false;
      showSnackBar('QuizID cannot be empty', redColor, whiteColor);
    }
  }

  decodeTeacherName(String? teacherID) async {
    log(teacherID.toString());
    var response = await https.get(
        Uri.parse(ApiConfig.getEndPointsUrl('auth/users/$teacherID')),
        headers: headers);
    var decode = jsonDecode(response.body);
    log('----------------------$decode and ${decode["name"]}');
    return decode["statusCode"] == 404 ? 'Unknown' : decode["name"];
  }

  checkThisQuizID() async {
    quizDebugPrint('here');
    try {
      var response = await https.get(
          Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/${quizID.value.text}')),
          headers: headers);
      var decode = jsonDecode(response.body);
      quizDebugPrint("${decode}ddd");
      if (decode["statusCode"] == 400) {
        isTapStartJoining.value = false;
        showSnackBar(decode["message"], redColor, whiteColor);
      } else if (decode["quiz_id"] != null && decode["status"] == "live") {
        //send to show deatil page about quiz.
        log(decode.toString());
        String tname = await decodeTeacherName(decode["conducted_by"]);
        quizDebugPrint("$tname----------------Tname");
        currentQuiz.isNotEmpty ? currentQuiz.clear() : null;
        currentQuiz.add(DetailedQuizJoinModel.fromJson(decode));
        currentQuiz[0].conductedBy =
            tname != 'Unknown' ? tname : currentQuiz[0].conductedBy;
        quizDebugPrint(
            "${currentQuiz[0].conductedBy}----------------changes name");
        navigateToDetailedPage();
      } else if (decode["status"] == "completed") {
        isTapStartJoining.value = false;
        showSnackBar('Quiz is completed ', redColor, whiteColor);
      } else {
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        LocalDB.removeLoacalDb();
        showSnackBar('Sessio Expired :)', greenColor, whiteColor);
      }
    } catch (e) {
      isTapStartJoining.value = false;
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }
}
