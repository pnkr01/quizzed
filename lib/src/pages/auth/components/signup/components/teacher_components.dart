import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import '../../../../../../theme/app_color.dart';
import '../../../../../../widget/custom_text_for_file.dart';
import '../../../../../global/strings.dart';
import '../../../controller/common_auth_register_controller.dart';

class TeacherSignUpScreen extends GetView<CommonAuthSignUpController> {
  const TeacherSignUpScreen({super.key});
  static const routeName = '/teacherSignUpScreen';

  @override
  Widget build(BuildContext context) {
    final focusedCtx = FocusManager.instance.primaryFocus!.context;
    Future.delayed(const Duration(milliseconds: 200)).then((_) =>
        Scrollable.ensureVisible(focusedCtx!,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                      GLobal.teacherInfo,
                      style: kBodyText3Style(),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.h),
            CustomTextFormField(
              labelText: 'Name',
              hintColor: kTeacherPrimaryColor,
              contentColor: kTeacherPrimaryColor,
              borderColor: kTeacherPrimaryColor,
              cursorColor: kTeacherPrimaryColor,
              labelColor: kTeacherPrimaryColor,
              isObscureText: false,
              controller: controller.tName.value,
            ),
            SizedBox(height: 14.h),
            CustomTextFormField(
              hintColor: kTeacherPrimaryColor,
              contentColor: kTeacherPrimaryColor,
              labelText: 'Email',
              borderColor: kTeacherPrimaryColor,
              cursorColor: kTeacherPrimaryColor,
              labelColor: kTeacherPrimaryColor,
              isObscureText: false,
              controller: controller.tEmail.value,
            ),
            SizedBox(height: 14.h),
            CustomTextFormField(
              hintColor: kTeacherPrimaryColor,
              contentColor: kTeacherPrimaryColor,
              labelText: 'Phone',
              borderColor: kTeacherPrimaryColor,
              cursorColor: kTeacherPrimaryColor,
              labelColor: kTeacherPrimaryColor,
              isObscureText: false,
              controller: controller.tPhone.value,
            ),
            SizedBox(height: 14.h),
            CustomTextFormField(
              hintColor: kTeacherPrimaryColor,
              contentColor: kTeacherPrimaryColor,
              labelText: 'Set Password',
              borderColor: kTeacherPrimaryColor,
              cursorColor: kTeacherPrimaryColor,
              labelColor: kTeacherPrimaryColor,
              isObscureText: true,
              controller: controller.tPassword.value,
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: CustomTextFormField(
                hintColor: kTeacherPrimaryColor,
                contentColor: kTeacherPrimaryColor,
                labelText: 'Confirm Password',
                borderColor: kTeacherPrimaryColor,
                cursorColor: kTeacherPrimaryColor,
                labelColor: kTeacherPrimaryColor,
                isObscureText: true,
                controller: controller.tConfirmPassword.value,
              ),
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
                    controller.checkForErrorAndRegisterForTeacher();
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
