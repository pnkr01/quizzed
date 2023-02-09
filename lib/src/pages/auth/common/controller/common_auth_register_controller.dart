import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/utils/errordialog.dart';
import 'package:quiz/utils/loading_dialog.dart';

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

  checkForErrorAndRegisterForStudent() {
    showDialog(
        context: Get.context!,
        builder: ((context) => const LoadingDialog(message: 'Please Wait')));
    log("Student signup");
    if (studentPassword.value.text.isNotEmpty &&
        studentRegdNo.value.text.isNotEmpty) {
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
      if (tPassword.value.text == tConfirmPassword.value.text) {
        showDialog(
            context: Get.context!,
            builder: ((context) => const ErrorDialog(
                message: 'Password and confirm password are different')));
      } else {
        //hit api
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
