import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quizzed/src/api/points.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/pages/auth/components/otp/otp_screen.dart';
import 'package:quizzed/utils/errordialog.dart';

import '../components/login/common_auth_login_screen.dart';

class CommonAuthSignUpController extends GetxController {
  RxBool isRegistering = true.obs;
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

  clearTextField() {
    studentRegdNo.value.clear();
    studentPassword.value.clear();
    tName.value.clear();
    tEmail.value.clear();
    tPhone.value.clear();
    tPassword.value.clear();
    tConfirmPassword.value.clear();
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
      quizDebugPrint(ApiConfig.getEndPointsUrl('auth/users'));
      var response = await https
          .post(Uri.parse(ApiConfig.getEndPointsUrl('auth/users')), body: {
        "regdNo": studentRegdNo.value.text,
        "password": studentPassword.value.text,
      });
      quizDebugPrint(response.statusCode.toString());
      quizDebugPrint(response.body);
      var res = jsonDecode(response.body);
      quizDebugPrint(res.toString());

      if (res["statusCode"] == 422 &&
          res["message"]
              .toString()
              .contains('User with similar details already')) {
        isRegistering.value = true;
        quizDebugPrint(
            'this student already registered in backend => Sending to login page');
        clearStudentField();
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        showSnackBar(
          "Student already exist, Please logIn",
          Colors.green,
          Colors.white,
        );
      } else if (res["name"] != null) {
        quizDebugPrint(
            'New User found => Sended data to backend => save data locally => send to home page');
        clearStudentField();
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        showSnackBar(
          "Registered sucessfully, please logIn",
          Colors.green,
          Colors.white,
        );
      } else {
        isRegistering.value = true;
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
      quizDebugPrint('inside catch block error in student body');
      isRegistering.value = true;
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
    quizDebugPrint("Student signup");
    //await getResponseFromStudentApi();
    if (studentPassword.value.text.isNotEmpty &&
        studentRegdNo.value.text.isNotEmpty) {
      await getResponseFromStudentApi();
      //hit api
      quizDebugPrint('all ok hitting student route');
    } else {
      quizDebugPrint('some field missing error');
      isRegistering.value = true;
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
      quizDebugPrint(response.statusCode.toString());
      var jsonBody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        quizDebugPrint('new Teacher detected => sending to OTP screen');
        isRegistering.value = true;
        navigateToOTPScreen(
          jsonBody["regdNo"],
          jsonBody["message"],
        );
      } else if (response.statusCode == 422) {
        quizDebugPrint('Teacher already exist');
        //showSnackBar and send teacher to LogIn page.
        isRegistering.value = true;
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        clearTeacherField();
        showSnackBar(
            jsonBody["message"] + "Please logIn", Colors.green, Colors.white);
      } else {
        quizDebugPrint('else part of teacher register page');
        isRegistering.value = true;
        showSnackBar(jsonBody["message"][0], Colors.red, Colors.white);
      }
    } catch (e) {
      isRegistering.value = true;
      showSnackBar(e.toString(), Colors.red, Colors.white);
    }
  }

  checkForErrorAndRegisterForTeacher() {
    quizDebugPrint("Teacher signup");
    if (tName.value.text.isNotEmpty &&
        tEmail.value.text.isNotEmpty &&
        tPhone.value.text.isNotEmpty &&
        tPassword.value.text.isNotEmpty &&
        tConfirmPassword.value.text.isNotEmpty) {
      if (tPassword.value.text != tConfirmPassword.value.text) {
        isRegistering.value = true;
        showDialog(
            context: Get.context!,
            builder: ((context) => const ErrorDialog(
                message: 'Password and Confirm Password should be same.')));
      } else {
        //hit api

        hitApiForTeacher();
        quizDebugPrint('hit teacher route');
      }
    } else {
      isRegistering.value = true;
      showDialog(
          context: Get.context!,
          builder: ((context) =>
              const ErrorDialog(message: 'Fill all blanks')));
    }
  }
}
