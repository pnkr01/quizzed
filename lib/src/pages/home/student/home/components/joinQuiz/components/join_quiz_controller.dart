import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../global/shared.dart';

class JoinQuizCOntroller extends GetxController {
  late Rx<TextEditingController> quizID;
  RxBool isTapStartJoining = false.obs;

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

  checkThisQuizID() async {
    try {
      var response = await https.get(
          Uri.parse(
              ApiConfig.getEndPointsNextUrl('quiz/join/${quizID.value.text}')),
          headers: headers);
      print(response.body);
      var decode = jsonDecode(response.body);
      if (decode["message"] != null &&
          decode["message"]
              .toString()
              .contains('Please provide a valid quiz id')) {
        isTapStartJoining.value = false;
        showSnackBar(decode["message"], redColor, whiteColor);
      } else {
        //correct quizID.
        isTapStartJoining.value = false;
        log('correct quizID');
        print(decode);
      }
    } catch (e) {
      isTapStartJoining.value = false;
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }
}
