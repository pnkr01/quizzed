import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/theme/app_color.dart';

import '../../../../utils/errordialog.dart';
import '../components/login/common_auth_login_screen.dart';

class OTPController extends GetxController {
  dynamic argumentData = Get.arguments;
  RxBool isStartingOtpVeryfication = false.obs;
  late Rx<TextEditingController> otp;
  @override
  void onInit() {
    otp = TextEditingController().obs;
    super.onInit();
  }

  @override
  void onReady() {
    showMessageDialog();
    super.onReady();
  }

  getRegdNo() => argumentData[0]['regdNo'] ?? "";
  getRegdMessage() => argumentData[1]['message'];

  showMessageDialog() {
    showDialog(
        context: Get.context!,
        builder: ((context) => ErrorDialog(
              color: kTeacherPrimaryColor,
              message: '${argumentData[1]['message']}',
            )));
  }

  @override
  void dispose() {
    otp.close();
    super.dispose();
  }

  getResponseFromOTPApi() async {
    quizDebugPrint(getRegdNo());
    quizDebugPrint(otp.value.text);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
      };
      final msg = json.encode({
        "regdNo": getRegdNo(),
        "otp": int.parse(otp.value.text),
      });

      var response = await https.post(
        Uri.parse(
          ApiConfig.getEndPointsUrl('auth/teachers/verify'),
        ),
        body: msg,
        headers: headers,
      );
      quizDebugPrint(response.statusCode.toString());
      var res = jsonDecode(response.body);

      quizDebugPrint(res.toString());

      if (response.statusCode == 201) {
        if (res['name'] != null) {
          quizDebugPrint('user sucessfully entered right otp');
          showSnackBar("Account validated Sucessfully, Please log In",
              Colors.green, Colors.white);
          isStartingOtpVeryfication.value = false;
          Get.offAllNamed(CommmonAuthLogInRoute.routeName);
          //LocalDB.saveTeacherData(res);654247 894750
          //
          showSnackBar("Account validated Sucessfully, Please log In",
              Colors.green, Colors.white);
          quizDebugPrint('went to login screen');
        } else {
          isStartingOtpVeryfication.value = false;
          quizDebugPrint('handle various issues using snackbar ');
          showSnackBar(res['message'], Colors.green, Colors.white);
          // Teacher.fromJson(res);

        }
      } else {
        isStartingOtpVeryfication.value = false;
        quizDebugPrint('handle various issues using snackbar ');
        showSnackBar(res['message'], Colors.red, Colors.white);
        // Teacher.fromJson(res);

      }
    } catch (e) {
      isStartingOtpVeryfication.value = false;
      showSnackBar(e.toString(), Colors.red, Colors.white);
    }
  }

  startCheckingOtp() async {
    //send post req to verify route.

    quizDebugPrint("User entered otp now checking otp => otp_controller.dart");
    //await getResponseFromStudentApi();
    if (otp.value.text.isNotEmpty) {
      await getResponseFromOTPApi();
      //hit api
      quizDebugPrint('hitting otp verify route');
    } else {
      isStartingOtpVeryfication.value = false;
      showDialog(
          context: Get.context!,
          builder: ((context) => const ErrorDialog(message: 'OTP is Empty')));
    }
  }
}
