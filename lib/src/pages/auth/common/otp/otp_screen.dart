import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/auth/common/controller/otp_controller.dart';
import 'package:quiz/utils/size_configuration.dart';
import 'package:quiz/widget/custom_elevated_bottom.dart';
import 'package:quiz/widget/custom_text_for_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../theme/app_color.dart';

class OTPScreen extends GetView<OTPController> {
  const OTPScreen({super.key});
  static const String routeName = '/otpScreen';

  @override
  Widget build(BuildContext context) {
    Get.put(OTPController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quizzed"),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(15.sp)),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(50.spMin),
              ),
              Obx(
                () => CustomTextFormField(
                  labelText: 'Enter OTP',
                  borderColor: kTextFormFieldBorderColor,
                  cursorColor: kTextFormFieldCursorColor,
                  labelColor: kTextFormFieldBorderColor,
                  isObscureText: true,
                  controller: controller.otp.value,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(18.sp),
              ),
              MYElevatedButton(
                label: "Continue",
                backgroundColor: Colors.white,
                function: () {
                  controller.startCheckingOtp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
