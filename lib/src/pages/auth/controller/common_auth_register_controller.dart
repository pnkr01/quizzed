import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/pages/auth/components/otp/otp_screen.dart';
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
      log(response.statusCode.toString());
      log(response.body);
      var res = jsonDecode(response.body);
      // log(res);

      if (response.statusCode == 422) {
        Get.back();
        log('this student already registered in backend => Sending to login page');
        clearStudentField();
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        showSnackBar(
          "Student already exist, Please logIn",
          Colors.green,
          Colors.white,
        );
      } else if (response.statusCode == 201) {
        log('New User found => Sended data to backend => save data locally => send to home page');
        clearStudentField();
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        showSnackBar(
          "Registered sucessfully, please logIn",
          Colors.green,
          Colors.white,
        );
      } else {
        Get.back();
        showSnackBar(res["message"], Colors.red, Colors.white);
      }
      // if (response.statusCode == 201) {
      //   //new user
      //   Student.fromJson(res);
      // } else if (response.statusCode == 422) {
      //   log('student already exist');
      //   var res = jsonDecode(response.body);
      //   //showSnackBar and send user to LogIn page.
      //   Get.back();
      //   Get.offNamed(CommmonAuthLogInRoute.routeName);
      //   clearStudentField();
      //   showSnackBar(
      //     "Quizzed",
      //     res["message"] + "Please logIn",
      //     Colors.blue,
      //   );
      // } else {
      //   throw Exception(response.body);
      // }
    } catch (e) {
      log('inside catch block error in student body');
      Get.back();
      showSnackBar(e.toString(), Colors.red, Colors.white);
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
      log('all ok hitting student route');
    } else {
      log('some field missing error');
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
      log(response.statusCode.toString());
      var jsonBody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        log('new Teacher detected => sending to OTP screen');
        Get.back();
        navigateToOTPScreen(
          jsonBody["regdNo"],
          jsonBody["message"],
        );
      } else if (response.statusCode == 422) {
        log('Teacher already exist');
        //showSnackBar and send teacher to LogIn page.
        Get.back();
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        clearTeacherField();
        showSnackBar(
            jsonBody["message"] + "Please logIn", Colors.green, Colors.white);
      } else {
        log('else part of teacher register page');
        Get.back();
        showSnackBar(jsonBody["message"], Colors.red, Colors.white);
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
