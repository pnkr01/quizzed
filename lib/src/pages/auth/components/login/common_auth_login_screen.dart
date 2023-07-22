import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_login_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/helper_widget.dart';
import 'package:quiz/utils/quizTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/quizElevatedButon.dart';
import '../../../../../utils/size_configuration.dart';

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
                        children: <Widget>[
                          const SizedBox(height: 20),
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
                          ),
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
                Image.asset(
                  kLogoPath,
                  width: 120.w,
                ),
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 4,
                ),
                Obx(
                  () => Container(
                    margin: const EdgeInsets.only(
                      left: 4,
                      top: 14,
                      right: 4,
                    ),
                    child: TextFormField(
                      style: const TextStyle(color: whiteColor),
                      obscureText: !controller.isObscure.value,
                      controller: controller.password.value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        hintStyle: kBodyText3Style()
                            .copyWith(color: whiteColor, fontSize: 12),
                        labelStyle: kElevatedButtonTextStyle()
                            .copyWith(color: whiteColor),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14.r),
                          ),
                          borderSide: const BorderSide(color: whiteColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                                getProportionateScreenHeight(14.sp)),
                          ),
                          borderSide: const BorderSide(
                            color: whiteColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.switchObscure();
                          },
                          icon: controller.isObscure.value
                              ? const Icon(Icons.visibility, color: whiteColor)
                              : const Icon(Icons.visibility_off,
                                  color: whiteColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                QuizElevatedButton(
                    label: Obx(() => controller.isStartedLogginIn.value == false
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
                      if (controller.regdNo.value.text.isNotEmpty &&
                          controller.password.value.text.isNotEmpty) {
                        controller.isStartedLogginIn.value = true;
                        controller.checkIMEIPermission();
                        FocusScope.of(context).unfocus();
                      } else {
                        showSnackBar("fill all blanks", blackColor, whiteColor);
                      }
                      //ask for IMEI
                    }),
                const SizedBox(
                  height: 10,
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
