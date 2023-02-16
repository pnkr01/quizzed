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
        elevation: 0,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text('Quizzed'),
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(18.spMin),
              ),
              ToggleSwitch(
                minHeight: getProportionateScreenHeight(45.sp),
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
                  [Colors.blue],
                  [Colors.green]
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
                          color: Colors.yellow,
                          size: getProportionateScreenHeight(24.sp),
                        ),
                        SizedBox(
                          width: getProportionateScreenHeight(4.sp),
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
                      height: getProportionateScreenHeight(24.sp),
                    ),
                    Obx(() => controller.getIndexValue() == 0
                        ? Column(
                            children: [
                              Obx(
                                () => CustomTextFormField(
                                  labelText: 'Regd No',
                                  borderColor: kTextFormFieldBorderColor,
                                  cursorColor: kTextFormFieldCursorColor,
                                  labelColor: kTextFormFieldBorderColor,
                                  isObscureText: false,
                                  controller: controller.studentRegdNo.value,
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(18.sp),
                              ),
                              Obx(
                                () => CustomTextFormField(
                                  labelText: 'Password',
                                  borderColor: kTextFormFieldBorderColor,
                                  cursorColor: kTextFormFieldCursorColor,
                                  labelColor: kTextFormFieldBorderColor,
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
                                  borderColor: kTextFormFieldBorderColor,
                                  cursorColor: kTextFormFieldCursorColor,
                                  labelColor: kTextFormFieldBorderColor,
                                  isObscureText: false,
                                  controller: controller.tName.value,
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(18.sp),
                              ),
                              Obx(
                                () => CustomTextFormField(
                                  labelText: 'Email',
                                  borderColor: kTextFormFieldBorderColor,
                                  cursorColor: kTextFormFieldCursorColor,
                                  labelColor: kTextFormFieldBorderColor,
                                  isObscureText: false,
                                  controller: controller.tEmail.value,
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(18.sp),
                              ),
                              Obx(
                                () => CustomTextFormField(
                                  labelText: 'Phone',
                                  borderColor: kTextFormFieldBorderColor,
                                  cursorColor: kTextFormFieldCursorColor,
                                  labelColor: kTextFormFieldBorderColor,
                                  isObscureText: false,
                                  controller: controller.tPhone.value,
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(18.sp),
                              ),
                              Obx(
                                () => CustomTextFormField(
                                  labelText: 'Set Password',
                                  borderColor: kTextFormFieldBorderColor,
                                  cursorColor: kTextFormFieldCursorColor,
                                  labelColor: kTextFormFieldBorderColor,
                                  isObscureText: true,
                                  controller: controller.tPassword.value,
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(18.sp),
                              ),
                              Obx(
                                () => CustomTextFormField(
                                  labelText: 'Confirm Password',
                                  borderColor: kTextFormFieldBorderColor,
                                  cursorColor: kTextFormFieldCursorColor,
                                  labelColor: kTextFormFieldBorderColor,
                                  isObscureText: true,
                                  controller: controller.tConfirmPassword.value,
                                ),
                              ),
                            ],
                          )),
                    SizedBox(
                      height: getProportionateScreenHeight(24.sp),
                    ),
                    MYElevatedButton(
                      label: "Register",
                      backgroundColor: Colors.white,
                      function: () {
                        controller.getIndexValue() == 0
                            ? controller.checkForErrorAndRegisterForStudent()
                            : controller.checkForErrorAndRegisterForTeacher();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
