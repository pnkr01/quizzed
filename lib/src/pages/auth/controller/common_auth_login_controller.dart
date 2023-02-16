import 'dart:convert';
import 'dart:developer';
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
import 'package:quiz/utils/loading_dialog.dart';

import '../components/otp/otp_screen.dart';

class CommonAuthLogInController extends GetxController {
  late Rx<TextEditingController> regdNo;
  late Rx<TextEditingController> password;

  @override
  void onInit() {
    regdNo = TextEditingController().obs;
    password = TextEditingController().obs;
    super.onInit();
  }

  @override
  void onClose() {
    regdNo.close();
    password.close();
    super.onClose();
  }

  navigateToSignUpScreen() {
    Get.toNamed(CommonAuthSignUpScreen.routeName);
  }

  setLocalIndex() {
    sharedPreferences.setBool('studentLogged', true);
  }

  saveTeacherIndex(var res) async {
    await LocalDB.saveTeacherData(res);
  }

  navigateToteacherHomePage() {
    Get.offAllNamed(TeacherHome.routeName);
    showSnackBar("Sucessfully logged In", Colors.green, Colors.white);
    sharedPreferences.setBool('teacherLoggedIN', true);
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
        Get.offAllNamed(StudentHome.routeName);
        await setLocalIndex();
        showSnackBar("Sucessfully logged In", Colors.green, Colors.white);
      }
      if (res["type"] == "teacher" && res["status"] == "active") {
        log('tecaher data available=> save this and log in');
        await saveTeacherIndex(res);
        navigateToteacherHomePage();
      } else {
        log('else part of login screen');
        Get.back();
        showSnackBar(res["message"], Colors.red, Colors.white);
      }
    } else if (response.statusCode == 404) {
      Get.back();
      showSnackBar("Please signup then login", Colors.red, Colors.white);
    } else if (res["error"] == "Unauthorized" &&
        res["message"]
            .toString()
            .contains('Your account is not verified yet')) {
      log('inactive teacher.');
      log('sending => to otp screen');
      Get.toNamed(
        OTPScreen.routeName,
        arguments: [
          {"regdNo": regdNo.value.text},
          {"message": res["message"]},
        ],
      );
    } else {
      Get.back();
      showSnackBar(res["message"], Colors.red, Colors.white);
    }
  }

  checkForErrorAndStartLoggingInUser() {
    showDialog(
        context: Get.context!,
        builder: ((context) => const LoadingDialog(message: 'Please Wait...')));
    if (regdNo.value.text.isNotEmpty && password.value.text.isNotEmpty) {
      log('hitting login Api');
      hitLoginApi();
    } else {
      showDialog(
          context: Get.context!,
          builder: ((context) =>
              const ErrorDialog(message: 'fill all details')));
    }
  }
}
