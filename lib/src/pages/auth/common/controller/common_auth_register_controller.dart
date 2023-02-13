import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/model/student_model.dart';
import 'package:quiz/src/pages/auth/common/otp/otp_screen.dart';
import 'package:quiz/utils/errordialog.dart';
import 'package:quiz/utils/loading_dialog.dart';

import '../components/login/common_auth_login_screen.dart';

class CommonAuthSignUpController extends GetxController {
  late Rx<TextEditingController> studentRegdNo;
  late Rx<TextEditingController> studentPassword;
  late Rx<TextEditingController> tName;
  late Rx<TextEditingController> tEmail;
  late Rx<TextEditingController> tPhone;
  late Rx<TextEditingController> tPassword;
  late Rx<TextEditingController> tConfirmPassword;

  @override
  void onInit() {
    studentRegdNo = TextEditingController().obs;
    studentPassword = TextEditingController().obs;
    tName = TextEditingController().obs;
    tEmail = TextEditingController().obs;
    tPhone = TextEditingController().obs;
    tConfirmPassword = TextEditingController().obs;
    tPassword = TextEditingController().obs;
    super.onInit();
  }

  @override
  void onClose() {
    studentRegdNo.close();
    studentPassword.close();
    tName.close();
    tEmail.close();
    tPhone.close();
    tPassword.close();
    tConfirmPassword.close();
    super.onClose();
  }

  RxInt index = 0.obs;

  getIndexValue() => index.value;
  setIndexValue(int newIdx) => index.value = newIdx;

  teacherBody() {
    return {
      "name": tName.value.text,
      "email": tEmail.value.text,
      "primaryPhone": tPhone.value.text,
      "password": tPassword.value.text,
    };
  }

  getResponseFromStudentApi() async {
    //http://10.0.2.2:8001/auth/users

    try {
      var response = await https
          .post(Uri.parse(ApiConfig.getEndPointsUrl('auth/users')), body: {
        "regdNo": studentRegdNo.value.text,
        "password": studentPassword.value.text,
      });
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        //new user
        var res = jsonDecode(response.body);
        Student.fromJson(res);
      } else if (response.statusCode == 422) {
        log('student already exist');
        var res = jsonDecode(response.body);
        //showSnackBar and send user to LogIn page.
        Get.back();
        Get.offNamed(CommmonAuthLogInRoute.routeName);
        clearStudentField();
        showSnackBar(
          "Quizzed",
          res["message"] + "Please logIn",
          Colors.blue,
        );
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), Colors.red, Colors.white);
    }
  }

  setAndHandleNewStudent(value) {
    if (kDebugMode) {
      print(value.body);
    }
  }

  clearStudentField() {
    studentRegdNo.value.clear();
    studentPassword.value.clear();
  }

  clearTeacherField() {
    tName.value.clear();
    tEmail.value.clear();
    tConfirmPassword.value.clear();
    tPassword.value.clear();
    tPhone.value.clear();
  }

  setAndHandleOldStudent(value) {
    if (kDebugMode) {
      print(value.body);
    }
  }

  checkForErrorAndRegisterForStudent() async {
    showDialog(
        context: Get.context!,
        builder: ((context) => const LoadingDialog(message: 'Please Wait')));
    log("Student signup");
    //await getResponseFromStudentApi();
    if (studentPassword.value.text.isNotEmpty &&
        studentRegdNo.value.text.isNotEmpty) {
      await getResponseFromStudentApi();
      //hit api
      log('hit student route');
    } else {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: ((context) =>
              const ErrorDialog(message: 'Fill all blanks')));
    }
  }

  navigateToOTPScreen(String regdNo, String message) {
    Get.toNamed(
      OTPScreen.routeName,
      arguments: [
        {"regdNo": regdNo},
        {"message": message},
      ],
    );
  }

  hitApiForTeacher() async {
    try {
      var response = await https
          .post(Uri.parse(ApiConfig.getEndPointsUrl('auth/teachers')), body: {
        "name": tName.value.text,
        "email": tEmail.value.text,
        "primaryPhone": tPhone.value.text,
        "password": tPassword.value.text,
      });
      if (response.statusCode == 201) {
        //created Teacher
        //decode regdNo for teacher send to otpscreen
        //send to OTP Screen
        var jsonBody = jsonDecode(response.body);
        Get.back();
        navigateToOTPScreen(
          jsonBody["regdNo"],
          jsonBody["message"],
        );

        log(response.body);
      } else if (response.statusCode == 422) {
        log('Teacher already exist');
        var res = jsonDecode(response.body);
        //showSnackBar and send teacher to LogIn page.
        Get.back();
        Get.offNamed(CommmonAuthLogInRoute.routeName);
        clearTeacherField();
        showSnackBar(
            res["message"] + "Please logIn", Colors.blue, Colors.white);
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), Colors.red, Colors.white);
    }
  }

  checkForErrorAndRegisterForTeacher() {
    showDialog(
        context: Get.context!,
        builder: ((context) => const LoadingDialog(message: 'Please Wait')));
    log("Teacher signup");
    if (tName.value.text.isNotEmpty &&
        tEmail.value.text.isNotEmpty &&
        tPhone.value.text.isNotEmpty &&
        tPassword.value.text.isNotEmpty &&
        tConfirmPassword.value.text.isNotEmpty) {
      print(tPassword.value.text);
      print(tConfirmPassword.value.text);
      if (tPassword.value.text != tConfirmPassword.value.text) {
        Get.back();
        showDialog(
            context: Get.context!,
            builder: ((context) => const ErrorDialog(
                message: 'Password and Confirm Password should be same.')));
      } else {
        //hit api

        hitApiForTeacher();
        log('hit teacher route');
      }
    } else {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: ((context) =>
              const ErrorDialog(message: 'Fill all blanks')));
    }
  }
}
