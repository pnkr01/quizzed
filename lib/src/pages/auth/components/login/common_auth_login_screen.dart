import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_login_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/widget/custom_elevated_bottom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/widget/custom_text_for_file.dart';

class CommmonAuthLogInRoute extends GetView<CommonAuthLogInController> {
  const CommmonAuthLogInRoute({super.key});
  static const String routeName = '/commonAuthLogInRoute';
  @override
  Widget build(BuildContext context) {
    Get.put(CommonAuthLogInController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25.w),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Image.asset(
                  kLogoPath,
                  width: 150.w,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                  () => CustomTextFormField(
                    labelText: 'Regd No',
                    borderColor: kTextFormFieldBorderColor,
                    cursorColor: kTextFormFieldCursorColor,
                    labelColor: kTextFormFieldBorderColor,
                    isObscureText: false,
                    controller: controller.regdNo.value,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Obx(
                  () => CustomTextFormField(
                    labelText: 'Password',
                    borderColor: kTextFormFieldBorderColor,
                    cursorColor: kTextFormFieldCursorColor,
                    labelColor: kTextFormFieldBorderColor,
                    isObscureText: true,
                    controller: controller.password.value,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                MYElevatedButton(
                  label: "Continue",
                  backgroundColor: Colors.white,
                  function: () {
                    controller.checkForErrorAndStartLoggingInUser();
                    FocusScope.of(context).unfocus();
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                MYElevatedButton(
                  label: "Sign Up",
                  backgroundColor: Colors.white,
                  function: () {
                    controller.navigateToSignUpScreen();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
