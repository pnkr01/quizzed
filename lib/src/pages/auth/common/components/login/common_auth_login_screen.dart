import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/auth/common/controller/common_auth_login_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/utils/size_configuration.dart';
import 'package:quiz/widget/custom_elevated_bottom.dart';
import 'package:quiz/widget/custom_text_for_file.dart';

class CommmonAuthLogInRoute extends GetView<CommonAuthLogInController> {
  const CommmonAuthLogInRoute({super.key});
  static const String routeName = '/commonAuthLogInRoute';
  @override
  Widget build(BuildContext context) {
   // Get.put(() => CommonAuthLogInController());
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(80),
                ),
                Image.asset(
                  kLogoPath,
                  height: 200,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(21),
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
                  height: getProportionateScreenHeight(21),
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
                  height: getProportionateScreenHeight(21),
                ),
                MYElevatedButton(
                  label: "Continue",
                  backgroundColor: Colors.white,
                  function: () {},
                ),
                SizedBox(
                  height: getProportionateScreenHeight(21),
                ),
                MYElevatedButton(
                  label: "Sign Up",
                  backgroundColor: Colors.white,
                  function: () {
                    controller.navigateToSignUpScreen();
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
