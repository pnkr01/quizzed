import 'dart:async';
import 'dart:convert';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quiz/theme/app_color.dart';

import '../src/db/local/local_db.dart';
import '../src/pages/home/student/home/student_home.dart';
import '../theme/gradient_theme.dart';
import 'completed_confirmation.dart';

class TimerWidgetHelper extends StatefulWidget {
  final String quizID;
  const TimerWidgetHelper({
    Key? key,
    required this.quizID,
  }) : super(key: key);

  @override
  _TimerWidgetHelperState createState() => _TimerWidgetHelperState();
}

class _TimerWidgetHelperState extends State<TimerWidgetHelper> {
  int remainingTime = 0;
  Timer? timer;
  Timer? mixtimer;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    fetchRemainingTime(widget.quizID);
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': 'Authentication=${sharedPreferences.getString('Scookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    stopMix();
    super.dispose();
    quizDebugPrint('dispoing');
  }

  void fetchRemainingTime(quizID) async {
    // Make an API call to retrieve remaining time
    var response = await http.get(
        Uri.parse(
            ApiConfig.getEndPointsNextUrl('quiz/get-remaining-time/$quizID')),
        headers: headers);
    if (response.statusCode == 200) {
      var decodeTime = jsonDecode(response.body);
      setState(() {
        quizDebugPrint('min is ----${decodeTime['remainingMinutes']}');
        remainingTime = decodeTime['remainingMinutes'] * 60 +
            decodeTime['remainingSeconds'];
        isloading = !isloading;
      });
      startTimer(decodeTime);
    }
  }


  void startTimer(decode) async {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      //   setState(() {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
        if (decode["remainingMinutes"] == 0 &&
            decode["remainingSeconds"] <= 5) {
          quizDebugPrint('lesss');
          await FlutterDnd.setInterruptionFilter(
              FlutterDnd.INTERRUPTION_FILTER_ALL);
          timer?.cancel();
          sharedPreferences.setBool(widget.quizID, true);
          Get.offAllNamed(StudentHome.routeName);
          showDialog(
              context: Get.context!,
              builder: ((context) => const CompleteConfirmationDialog()));
          timer?.cancel();
          stopMix();
          //hit marks route.
        } else if (decode["remainingMinutes"] == null) {
          await FlutterDnd.setInterruptionFilter(
              FlutterDnd.INTERRUPTION_FILTER_ALL);
          timer?.cancel();
          Get.offAllNamed(CommmonAuthLogInRoute.routeName);
          showSnackBar('Session Expired :(', redColor, whiteColor);
          LocalDB.removeLoacalDb();
          stopMix();
        }
        quizDebugPrint(remainingTime);
      }
    });
  }

  stopMix() {
    if (mixtimer != null) {
      mixtimer?.cancel();
    }
  }

  String formatTime(int time) {
    int minutes = (time ~/ 60);
    int seconds = time % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1,
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              formatTime(remainingTime),
              style: const TextStyle(
                  fontSize: 14,
                  color: kTeacherPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
          );
  }
}
