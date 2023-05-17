import 'dart:convert';
import 'package:flutter/material.dart';
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
  late TextEditingController quizID;
  RxBool isTapStartJoining = false.obs;

  List<DetailedQuizJoinModel> currentQuiz = [];

  bool get showLoading => isTapStartJoining.value;
  @override
  void onInit() {
    quizID = TextEditingController();
    super.onInit();
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Scookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  navigateToDetailedPage() {
    Get.to(() => DetailedQuizViewScreen(model: currentQuiz.first));
    isTapStartJoining.value = false;
  }

  checkEmptyFilled() {
    if (quizID.text.isNotEmpty &&
        sharedPreferences.getBool(quizID.text.toUpperCase()) == null) {
      checkThisQuizID();
    } else if (sharedPreferences.getBool(quizID.text.toUpperCase()) != null) {
      isTapStartJoining.value = false;
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Your quiz is already submitted',
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kTeacherPrimaryColor),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Okay'),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      isTapStartJoining.value = false;
      showSnackBar('QuizID cannot be empty', redColor, whiteColor);
    }
  }

  decodeTeacherName(String? teacherID) async {
    quizDebugPrint(teacherID.toString());
    var response = await https.get(
        Uri.parse(ApiConfig.getEndPointsUrl('auth/users/$teacherID')),
        headers: headers);
    var decode = jsonDecode(response.body);
    quizDebugPrint('----------------------$decode and ${decode["name"]}');
    return decode["statusCode"] == 404 ? 'Unknown' : decode["name"];
  }

  checkThisQuizID() async {
    quizDebugPrint('here line 87 join_quiz_controller.dart');
    try {
      var response = await https.get(
          Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/${quizID.value.text}')),
          headers: headers);
      var decode = jsonDecode(response.body);
      quizDebugPrint("$decode is the value of quiz");
      if (decode["statusCode"] == 400) {
        quizDebugPrint(
            'the status code is 400 and message is ${decode["message"]}');
        isTapStartJoining.value = false;
        showSnackBar(decode["message"], redColor, whiteColor);
      } else if (decode["quiz_id"] != null && decode["status"] == "live") {
        //send to show deatil page about quiz....
        quizDebugPrint(
            'the status is $decode and message coming from 103 join_quiz_controller.dart');
        String tname = await decodeTeacherName(decode["conducted_by"]);
        currentQuiz.isNotEmpty ? currentQuiz.clear() : null;
        currentQuiz.add(DetailedQuizJoinModel.fromJson(decode));
        currentQuiz[0].conductedBy =
            tname != 'Unknown' ? tname : currentQuiz[0].conductedBy;
        quizDebugPrint(
            'teacher name updated sucessfully 109 sending to -------- detailedpage');
        navigateToDetailedPage();
      } else if (decode["status"] == "completed") {
        quizDebugPrint(
            'the status is completed and message coming from 114 join_quiz_controller.dart');
        isTapStartJoining.value = false;
        showSnackBar('Quiz is completed ', redColor, whiteColor);
      } else {
        quizDebugPrint(
            'the status session expired from 119 in join_quiz_controller.dart');
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        LocalDB.removeLoacalDb();
        showSnackBar('Session Expired :)', greenColor, whiteColor);
      }
    } catch (e) {
      isTapStartJoining.value = false;
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }
}
