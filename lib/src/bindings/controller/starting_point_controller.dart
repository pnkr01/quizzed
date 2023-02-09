import 'dart:async';

import 'package:get/get.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/pages/auth/common/components/login/common_auth_login_screen.dart';

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
    sharedPreferences.getString('logged') != null
        ? navigateToHome()
        : navigateToCommonAuthScreen();
  }

  navigateToHome() {
    //send to home page
  }
  navigateToCommonAuthScreen() {
    //send to auth page
    Get.offNamed(CommmonAuthLogInRoute.routeName);
  }
}
