import 'dart:async';

import 'package:get/get.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quiz/src/pages/home/student/home/student_home.dart';
import 'package:quiz/src/pages/home/teacher/teacher_home.dart';

import '../../global/shared.dart';

class StartingPointController extends GetxController {
  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  startTimer() {
    Timer(const Duration(seconds: 2), () {
      takeDecision();
    });
  }

  takeDecision() {
    if (sharedPreferences.getBool('studentLogged') == null) {
      //send to student home
      navigateToStudentHome();
    } else if (sharedPreferences.getBool('teacherLoggedIN') != null) {
      navigateToTeacherHome();
    } else {
      navigateToCommonAuthScreen();
    }
  }

  navigateToStudentHome() {
    //send to home page
    Get.offAllNamed(StudentHome.routeName);
  }

  navigateToTeacherHome() {
    //send to home page
    Get.offAllNamed(TeacherHome.routeName);
  }

  navigateToCommonAuthScreen() {
    //send to auth page
    Get.offNamed(CommmonAuthLogInRoute.routeName);
  }
}
