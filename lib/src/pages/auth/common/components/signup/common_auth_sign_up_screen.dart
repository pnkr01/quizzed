import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/auth/common/controller/common_auth_register_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/utils/size_configuration.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../../../theme/gradient_theme.dart';
import '../../../../../../widget/custom_elevated_bottom.dart';
import '../../../../../../widget/custom_text_for_file.dart';

class CommonAuthSignUpScreen extends GetView<CommonAuthSignUpController> {
  const CommonAuthSignUpScreen({super.key});
  static const String routeName = '/commonAuthSignUpRoute';
  @override
  Widget build(BuildContext context) {
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
                height: getProportionateScreenHeight(18),
              ),
              ToggleSwitch(
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
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 10,
                  top: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Obx(
                            () => Text(
                              controller.getIndexValue() == 0
                                  ? GLobal.studentInfo
                                  : GLobal.teacherInfo,
                              style: kTextStyle().copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(35),
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
                                height: getProportionateScreenHeight(24),
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
                                height: getProportionateScreenHeight(24),
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
                                height: getProportionateScreenHeight(24),
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
                                height: getProportionateScreenHeight(24),
                              ),
                              Obx(
                                () => CustomTextFormField(
                                  labelText: 'Set Password',
                                  borderColor: kTextFormFieldBorderColor,
                                  cursorColor: kTextFormFieldCursorColor,
                                  labelColor: kTextFormFieldBorderColor,
                                  isObscureText: false,
                                  controller: controller.tPassword.value,
                                ),
                              ),
                            ],
                          )),
                    SizedBox(
                      height: getProportionateScreenHeight(24),
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
