import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_register_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/utils/size_configuration.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../theme/gradient_theme.dart';
import '../../../../../widget/custom_elevated_bottom.dart';
import '../../../../../widget/custom_text_for_file.dart';

class CommonAuthSignUpScreen extends GetView<CommonAuthSignUpController> {
  const CommonAuthSignUpScreen({super.key});
  static const String routeName = '/commonAuthSignUpRoute';
  @override
  Widget build(BuildContext context) {
    Get.put(CommonAuthSignUpController());
    controller.setIndexValue(0);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Quizzed',
          style: kAppBarTextStyle(),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            ToggleSwitch(
              minHeight: getProportionateScreenHeight(30.h),
              animate: true,
              minWidth: double.infinity,
              initialLabelIndex: 0,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.white,
              inactiveFgColor: Colors.grey,
              totalSwitches: 2,
              labels: const ['Student', 'Teacher'],
              icons: const [
                Icons.person,
                Icons.school,
              ],
              activeBgColors: const [
                [kPrimaryColor],
                [kPrimaryColor]
              ],
              onToggle: (index) {
                controller.setIndexValue(index ?? 0);
                // print(controller.getIndexValue());
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenHeight(12.w),
                right: getProportionateScreenHeight(12.w),
                top: getProportionateScreenHeight(12.h),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: greyColor,
                        size: getProportionateScreenHeight(24.sp),
                      ),
                      SizedBox(
                        width: getProportionateScreenHeight(4.w),
                      ),
                      Flexible(
                        child: Obx(
                          () => Text(
                            controller.getIndexValue() == 0
                                ? GLobal.studentInfo
                                : GLobal.teacherInfo,
                            style: kTitleTextStyle().copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Obx(() => controller.getIndexValue() == 0
                      ? Column(
                          children: [
                            Obx(
                              () => CustomTextFormField(
                                labelText: 'Regd No',
                                borderColor: kTextFormFieldContentColor,
                                cursorColor: kTextFormFieldContentColor,
                                labelColor: kTextFormFieldContentColor,
                                isObscureText: false,
                                controller: controller.studentRegdNo.value,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Obx(
                              () => CustomTextFormField(
                                labelText: 'Password',
                                borderColor: kTextFormFieldContentColor,
                                cursorColor: kTextFormFieldContentColor,
                                labelColor: kTextFormFieldContentColor,
                                isObscureText: true,
                                controller: controller.studentPassword.value,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Obx(
                              () => CustomTextFormField(
                                labelText: 'Name',
                                borderColor: kTextFormFieldContentColor,
                                cursorColor: kTextFormFieldContentColor,
                                labelColor: kTextFormFieldContentColor,
                                isObscureText: false,
                                controller: controller.tName.value,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Obx(
                              () => CustomTextFormField(
                                labelText: 'Email',
                                borderColor: kTextFormFieldContentColor,
                                cursorColor: kTextFormFieldContentColor,
                                labelColor: kTextFormFieldContentColor,
                                isObscureText: false,
                                controller: controller.tEmail.value,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Obx(
                              () => CustomTextFormField(
                                labelText: 'Phone',
                                borderColor: kTextFormFieldContentColor,
                                cursorColor: kTextFormFieldContentColor,
                                labelColor: kTextFormFieldContentColor,
                                isObscureText: false,
                                controller: controller.tPhone.value,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Obx(
                              () => CustomTextFormField(
                                labelText: 'Set Password',
                                borderColor: kTextFormFieldContentColor,
                                cursorColor: kTextFormFieldContentColor,
                                labelColor: kTextFormFieldContentColor,
                                isObscureText: true,
                                controller: controller.tPassword.value,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Obx(
                              () => CustomTextFormField(
                                labelText: 'Confirm Password',
                                borderColor: kTextFormFieldContentColor,
                                cursorColor: kTextFormFieldContentColor,
                                labelColor: kTextFormFieldContentColor,
                                isObscureText: true,
                                controller: controller.tConfirmPassword.value,
                              ),
                            ),
                          ],
                        )),
                  SizedBox(height: 28.h),
                  MYElevatedButton(
                    label: "Register",
                    backgroundColor: Colors.white,
                    function: () {
                      controller.getIndexValue() == 0
                          ? controller.checkForErrorAndRegisterForStudent()
                          : controller.checkForErrorAndRegisterForTeacher();
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
