import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzed/src/global/strings.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import '../../../../../../theme/app_color.dart';
import '../../../../../../widget/custom_text_for_file.dart';
import '../../../controller/common_auth_register_controller.dart';

class StudentSignUpScreen extends GetView<CommonAuthSignUpController> {
  const StudentSignUpScreen({super.key});
  static const routeName = '/StudentSignUpScreen';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                  color: kTeacherPrimaryLightColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: whiteColor,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Flexible(
                        child: Text(
                      GLobal.studentInfo,
                      style: kBodyText3Style(),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.h),
            CustomTextFormField(
              hintColor: kTeacherPrimaryColor,
              contentColor: kTeacherPrimaryColor,
              labelText: 'Regd No',
              borderColor: kTeacherPrimaryColor,
              cursorColor: kTeacherPrimaryColor,
              labelColor: kTeacherPrimaryColor,
              isObscureText: false,
              controller: controller.studentRegdNo.value,
            ),
            SizedBox(height: 14.h),
            CustomTextFormField(
              hintColor: kTeacherPrimaryColor,
              contentColor: kTeacherPrimaryColor,
              labelText: 'Password',
              borderColor: kTeacherPrimaryColor,
              cursorColor: kTeacherPrimaryColor,
              labelColor: kTeacherPrimaryColor,
              isObscureText: true,
              controller: controller.studentPassword.value,
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    backgroundColor: kTeacherPrimaryColor,
                  ),
                  onPressed: () {
                    controller.isRegistering.value = false;
                    controller.checkForErrorAndRegisterForStudent();
                    FocusScope.of(context).unfocus();
                  },
                  child: Obx(() => controller.isRegistering.value == true
                      ? Text(
                          'Register',
                          style: kBodyText3Style(),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: whiteColor,
                          ),
                        ))),
            ),
          ],
        ),
      ),
    );
  }
}
