import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/auth/common/components/signup/common_auth_sign_up_screen.dart';
import 'package:quiz/utils/errordialog.dart';

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

  checkForErrorAndStartLoggingInUser() {
    if (regdNo.value.text.isNotEmpty && password.value.text.isNotEmpty) {
    } else {
      showDialog(
          context: Get.context!,
          builder: ((context) =>
              const ErrorDialog(message: 'fill all details')));
    }
  }
}
