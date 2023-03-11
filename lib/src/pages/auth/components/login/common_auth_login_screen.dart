import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_login_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/helper_widget.dart';
import 'package:quiz/utils/quizElevatedButon.dart';
import 'package:quiz/utils/quizTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommmonAuthLogInRoute extends GetView<CommonAuthLogInController> {
  const CommmonAuthLogInRoute({super.key});
  static const String routeName = '/commonAuthLogInRoute';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTeacherPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                Obx(() => EnsureVisibleWhenFocused(
                    focusNode: controller.focusNodeRegdNo,
                    child: QuizTextFormField(
                      labelColor: whiteColor,
                      labelText: 'Regd No',
                      hintText: 'Enter Regd No.',
                      borderColor: whiteColor,
                      cursorColor: whiteColor,
                      hintColor: whiteColor,
                      isObscureText: false,
                      focusNode: controller.focusNodeRegdNo,
                      controller: controller.regdNo.value,
                    ))),
                SizedBox(
                  height: 15.h,
                ),
                Obx(() => EnsureVisibleWhenFocused(
                    focusNode: controller.focusNodePassword,
                    child: QuizTextFormField(
                      labelColor: whiteColor,
                      labelText: 'Password',
                      hintText: 'Enter password',
                      borderColor: whiteColor,
                      cursorColor: whiteColor,
                      hintColor: whiteColor,
                      isObscureText: true,
                      focusNode: controller.focusNodePassword,
                      controller: controller.password.value,
                    ))),
                SizedBox(
                  height: 20.h,
                ),
                QuizElevatedButton(
                    label: Obx(() => controller.isStartedLogginIn == false
                        ? Text(
                            'Continue',
                            style: kBodyText3Style()
                                .copyWith(color: kTeacherPrimaryColor),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: kTeacherPrimaryColor,
                              strokeWidth: 1,
                            ),
                          )),
                    backgroundColor: whiteColor,
                    function: () {
                      controller.isStartedLogginIn.value = true;

                      controller.checkForErrorAndStartLoggingInUser();
                      controller.clearThisField();
                      FocusScope.of(context).unfocus();
                    }),
                SizedBox(
                  height: 10.h,
                ),
                QuizElevatedButton(
                    label: Text(
                      'New? Sign Up',
                      style: kBodyText3Style()
                          .copyWith(color: kTeacherPrimaryColor),
                    ),
                    backgroundColor: whiteColor,
                    function: () {
                      controller.navigateToSignUpScreen();
                      FocusScope.of(context).unfocus();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
