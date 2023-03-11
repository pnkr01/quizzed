import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quiz/src/pages/auth/controller/otp_controller.dart';

import '../../../../../theme/app_color.dart';
import '../../../../../theme/gradient_theme.dart';

class OTPScreen extends GetView<OTPController> {
  const OTPScreen({super.key});
  static const String routeName = '/otpScreen';

  @override
  Widget build(BuildContext context) {
    Get.put(OTPController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: BottomSheet(
          enableDrag: false,
          backgroundColor: Colors.transparent,
          onClosing: () {},
          builder: (BuildContext context) {
            return Obx(
              () => controller.isStartingOtpVeryfication.value == false
                  ? Container(
                      width: double.infinity,
                      height: 50,
                      color: kTeacherPrimaryColor,
                      child: Center(
                        child: Text(
                          'Continue',
                          style: kBodyText3Style(),
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: kTeacherPrimaryColor,
                        strokeWidth: 1,
                      ),
                    ),
            );
          }),
      // bottomSheet:

      // SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: whiteColor,
      //         shape: const RoundedRectangleBorder(
      //             //  borderRadius: BorderRadius.circular(12), // <-- Radius
      //             ),
      //       ),
      //       onPressed: () {
      //         // myController.isRegistering.value = false;
      //         // tabIndex.value == 0
      //         //     ? myController.checkForErrorAndRegisterForStudent()
      //         //     : myController.checkForErrorAndRegisterForTeacher();
      //         FocusScope.of(context).unfocus();
      //       },
      //       child: Obx(() => controller.isStartingOtpVeryfication == false
      //           ? Text(
      //               'Continue',
      //               style:
      //                   kBodyText8Style().copyWith(color: kTeacherPrimaryColor),
      //             )
      //           : const Center(
      //               child: CircularProgressIndicator(
      //                 strokeWidth: 1,
      //                 color: whiteColor,
      //               ),
      //             ))),
      // ),
      appBar: AppBar(
        title: const Text("Quizzed"),
        backgroundColor: kTeacherPrimaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: kTeacherPrimaryLightColor,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: whiteColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "${"Your registration number is " + controller.getRegdNo()} for using Quizzed App. Please remmember this for login.",
                                  style: kBodyText3Style(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Obx(
                //   () => CustomTextFormField(
                //     labelText: 'Enter OTP',
                //     borderColor: kTextFormFieldContentColor,
                //     cursorColor: kTextFormFieldContentColor,
                //     labelColor: kTextFormFieldContentColor,
                //     isObscureText: true,
                //     controller: controller.otp.value,
                //   ),
                // ),
                // SizedBox(
                //   height: getProportionateScreenHeight(18.sp),
                // ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 500,
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://img.freepik.com/premium-vector/sign-concept-illustration_86047-297.jpg?w=826'),
                ),
                PinCodeTextField(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  backgroundColor: Colors.white,
                  onTap: () {
                    // canConfirmOtp.value = false;
                    // _otpCodeTextController.clear();
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp(r'\d'), allow: true)
                  ],
                  controller: controller.otp.value,
                  //  enabled: canConfirmOtp.value ? false : true,
                  enableActiveFill: true,
                  appContext: context,
                  hintCharacter: "*",
                  length: 6,
                  // backgroundColor: Colors.grey.shade200,
                  onCompleted: (String value) {
                    controller.isStartingOtpVeryfication.value = true;
                    // canConfirmOtp.value = true;
                    // otpCode = value;
                    //  mezDbgPrint(value);
                    controller.startCheckingOtp();
                  },
                  onChanged: (String s) {
                    //otpCode = s;
                  },

                  cursorColor: kTeacherPrimaryColor,
                  keyboardType: TextInputType.number,
                  textStyle:
                      const TextStyle(fontSize: 18, color: Colors.black87),
                  pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(5),
                    borderWidth: 0.0,
                    // fieldHeight: Get.width * 0.13,
                    fieldWidth: Get.width * 0.13,
                    shape: PinCodeFieldShape.box,
                    selectedFillColor: Colors.grey.shade100,
                    activeColor: Colors.transparent,
                    disabledColor: Colors.grey,
                    inactiveColor: Colors.transparent,
                    selectedColor: Colors.purple,
                    activeFillColor: Colors.grey.shade100,
                    inactiveFillColor: Colors.grey.shade100,
                  ),
                ),
                // OtpTextField(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   fieldWidth: 50,
                //   fillColor: whiteColor, textStyle: kBodyText3Style(),
                //   cursorColor: whiteColor,
                //   focusedBorderColor: kTeacherPrimaryLightColor,
                //   numberOfFields: 5,
                //   borderColor: kTeacherPrimaryColor,
                //   //set to true to show as 2box or false to show as dash
                //   showFieldAsBox: true,
                //   //runs when a code is typed in
                //   onCodeChanged: (String code) {
                //     //handle validation or checks here
                //   },
                //   //runs when every textfield is filled
                //   onSubmit: (String verificationCode) {
                //     showDialog(
                //         context: context,
                //         builder: (context) {
                //           return AlertDialog(
                //             title: const Text("Verification Code"),
                //             content: Text('Code entered is $verificationCode'),
                //           );
                //         });
                //   }, // end onSubmit
                // ),
                const SizedBox(
                  height: 50,
                ),
                // MYElevatedButton(
                //   textColor: kTeacherPrimaryColor,
                //   label: "Continue",
                //   backgroundColor: Colors.white,
                //   function: () {
                //     controller.startCheckingOtp();
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
