import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/db/local/local_db.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/auth/components/signup/common_auth_sign_up_screen.dart';
import 'package:quiz/src/pages/home/student/home/student_home.dart';
import 'package:quiz/src/pages/home/teacher/teacher_home.dart';
import 'package:quiz/utils/errordialog.dart';

import '../components/otp/otp_screen.dart';

class CommonAuthLogInController extends GetxController {
  late Rx<TextEditingController> regdNo;
  late Rx<TextEditingController> password;
  RxBool isStartedLogginIn = false.obs;
  final FocusNode focusNodeRegdNo = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  @override
  void onInit() {
    regdNo = TextEditingController().obs;
    password = TextEditingController().obs;
    super.onInit();
  }

  clearThisField() {
    regdNo.value.clear();
    password.value.clear();
  }

  setCookie(response) async {
    String rawCookie = response.headers['set-cookie']!;
    int index = rawCookie.indexOf(';');
    String refreshToken =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
    int idx = refreshToken.indexOf("=");
    if (kDebugMode) {
      print(refreshToken.substring(idx + 1).trim());
    }
    String cookieID = refreshToken.substring(idx + 1).trim();
    sharedPreferences.setString('Scookie', cookieID);
    log("Cookieeeeee  $cookieID");
  }

  navigateToSignUpScreen() {
    Get.toNamed(CommomAuthSignUpScreen.routeName);
  }

  setLocalIndex(var res) async {
    await LocalDB.saveStudentModel(res);
    sharedPreferences.setBool('studentLogged', true);
  }

  saveTeacherIndex(var res) async {
    await LocalDB.saveTeacherData(res);
    sharedPreferences.setBool('teacherLoggedIN', true);
  }

  navigateToteacherHomePage() {
    Get.offAllNamed(TeacherHome.routeName);
    showSnackBar("Sucessfully logged In", Colors.green, Colors.white);
  }

  hitLoginApi() async {
    var response = await https.post(
      Uri.parse(ApiConfig.getEndPointsUrl('auth/login')),
      body: {
        "regdNo": regdNo.value.text,
        "password": password.value.text,
      },
    );
    log(response.statusCode.toString());
    var res = jsonDecode(response.body);
    if (response.statusCode == 201) {
      log("connection created");
      if (res["name"] != null && res["type"] == "student") {
        log('pass and regd no verified => sending to student home page');
        log('saving user cookie');
        await setCookie(response);
        isStartedLogginIn.value = false;
        Get.offAllNamed(StudentHome.routeName);
        await setLocalIndex(res);
        showSnackBar("Sucessfully logged In", Colors.green, Colors.white);
      } else if (res["type"] == "teacher" && res["status"] == "active") {
        log('tecaher data available=> save this and log in');
        await saveTeacherIndex(res);
        await setTeacherCookie(response);
        isStartedLogginIn.value = false;
        navigateToteacherHomePage();
      } else {
        isStartedLogginIn.value = false;
        log('else part of login screen');
        showSnackBar(res["message"], Colors.red, Colors.white);
      }
    } else if (response.statusCode == 404) {
      isStartedLogginIn.value = false;
      showSnackBar("Please signup then login", Colors.red, Colors.white);
    } else if (res["error"] == "Unauthorized" &&
        res["message"]
            .toString()
            .contains('Your account is not verified yet')) {
      log('inactive teacher.');
      log('sending => to otp screen');
      isStartedLogginIn.value = false;
      Get.toNamed(
        OTPScreen.routeName,
        arguments: [
          {"regdNo": regdNo.value.text},
          {"message": res["message"]},
        ],
      );
    } else {
      isStartedLogginIn.value = false;
      showSnackBar(res["message"], Colors.red, Colors.white);
    }
  }

  checkForErrorAndStartLoggingInUser() {
    if (regdNo.value.text.isNotEmpty && password.value.text.isNotEmpty) {
      log('hitting login Api');
      try {
        hitLoginApi();
      } catch (e) {
        isStartedLogginIn.value = false;
        showSnackBar(e.toString(), Colors.red, Colors.white);
      }
    } else {
      isStartedLogginIn.value = false;
      showDialog(
          context: Get.context!,
          builder: ((context) =>
              const ErrorDialog(message: 'fill all details')));
    }
  }
}
