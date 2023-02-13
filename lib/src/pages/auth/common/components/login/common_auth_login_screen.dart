import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/auth/common/controller/common_auth_login_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/utils/size_configuration.dart';
import 'package:quiz/widget/custom_elevated_bottom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: EdgeInsets.all(getProportionateScreenHeight(12.sp)),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(35.sp),
                ),
                Image.asset(
                  kLogoPath,
                  height: getProportionateScreenHeight(150.sp),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(21.sp),
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
                  height: getProportionateScreenHeight(21.sp),
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
                  height: getProportionateScreenHeight(21.sp),
                ),
                MYElevatedButton(
                  label: "Continue",
                  backgroundColor: Colors.white,
                  function: () {},
                ),
                SizedBox(
                  height: getProportionateScreenHeight(21.sp),
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
