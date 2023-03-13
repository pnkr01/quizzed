import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/model/quiz_detailed_join_model.dart';

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

  checkThisQuizID() async {
    try {
      var response = await https.get(
          Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/${quizID.value.text}')),
          headers: headers);
      var decode = jsonDecode(response.body);
      print(decode);
      if (decode["statusCode"] == 400) {
        isTapStartJoining.value = false;
        showSnackBar(decode["message"], redColor, whiteColor);
      } else if (decode["quiz_id"] != null) {
        //send to show deatil page about quiz.
        log(decode.toString());
        currentQuiz.isNotEmpty ? currentQuiz.clear() : null;
        currentQuiz.add(DetailedQuizJoinModel.fromJson(decode));
        navigateToDetailedPage();
      } else {
        isTapStartJoining.value = false;
        showSnackBar(decode.toString(), redColor, whiteColor);
      }
    } catch (e) {
      isTapStartJoining.value = false;
      showSnackBar(e.toString(), redColor, whiteColor);
    }
    // try {
    //   var response = await https.get(
    //       Uri.parse(
    //           ApiConfig.getEndPointsNextUrl('quiz/join/${quizID.value.text}')),
    //       headers: headers);
    //   print(response.body);
    //   var decode = jsonDecode(response.body);
    //   if (decode["message"] != null &&
    //       decode["message"]
    //           .toString()
    //           .contains('Please provide a valid quiz id')) {
    //     isTapStartJoining.value = false;
    //     showSnackBar(decode["message"], redColor, whiteColor);
    //   } else {
    //     //correct quizID.

    //     log('correct quizID');
    //     print(decode);
    //     if (decode["statusCode"] == 400) {
    //       isTapStartJoining.value = false;
    //       showSnackBar(decode["message"], greenColor, whiteColor);
    //     }
    //     else if(decode["statusCode"]==200 &&){}
    //   }
    // } catch (e) {
    // isTapStartJoining.value = false;
    // showSnackBar(e.toString(), redColor, whiteColor);
    // }
  }
}
