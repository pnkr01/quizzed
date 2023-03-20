import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_login_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/helper_widget.dart';
import 'package:quiz/utils/quizTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/quizElevatedButon.dart';

class CommmonAuthLogInRoute extends GetView<CommonAuthLogInController> {
  const CommmonAuthLogInRoute({super.key});
  static const String routeName = '/commonAuthLogInRoute';
  @override
  Widget build(BuildContext context) {
    Get.put(CommonAuthLogInController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeacherPrimaryColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(14),
                        topLeft: Radius.circular(14))),
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10),
                          Text(
                            'Forgot Registration No?',
                            style: kBodyText11Style()
                                .copyWith(color: kTeacherPrimaryColor),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: QuizTextFormField(
                              contentColor: kTeacherPrimaryColor,
                              labelText: 'Email',
                              hintText: 'Enter your mail ID',
                              borderColor: kTeacherPrimaryColor,
                              cursorColor: kTeacherPrimaryColor,
                              hintColor: greyColor,
                              isObscureText: false,
                              controller: controller.forgotRegd,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kTeacherPrimaryColor,
                                    shape: const StadiumBorder()),
                                onPressed: () {
                                  controller.forgotHelper();
                                },
                                child: const Text('Continue'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      backgroundColor: kTeacherPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.all(25.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  kLogoPath,
                  width: 150.w,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                  () => EnsureVisibleWhenFocused(
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
                      )),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Obx(
                  () => EnsureVisibleWhenFocused(
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
                      )),
                ),
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
