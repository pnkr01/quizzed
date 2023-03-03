import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';

import '../../../../utils/errordialog.dart';
import '../../../../utils/loading_dialog.dart';
import '../components/login/common_auth_login_screen.dart';

class OTPController extends GetxController {
  dynamic argumentData = Get.arguments;
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
              message: '${argumentData[1]['message']}',
            )));
  }

  @override
  void dispose() {
    otp.close();
    super.dispose();
  }

  getResponseFromOTPApi() async {
    log(getRegdNo());
    log(otp.value.text);
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
      log(response.statusCode.toString());
      var res = jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (res['name'] != null) {
          log('user sucessfully entered right otp');
          showSnackBar("Account validated Sucessfully, Please log In",
              Colors.green, Colors.white);
          Get.offAllNamed(CommmonAuthLogInRoute.routeName);
          //LocalDB.saveTeacherData(res);654247 894750
          log('after'); //
          showSnackBar("Account validated Sucessfully, Please log In",
              Colors.green, Colors.white);
          log('went to login screen');
          Get.back();
        } else {
          Get.back();
          log('handle various issues using snackbar ');
          showSnackBar(res['message'], Colors.green, Colors.white);
          // Teacher.fromJson(res);

        }
      } else {
        Get.back();
        log('handle various issues using snackbar ');
        showSnackBar(res['message'], Colors.red, Colors.white);
        // Teacher.fromJson(res);

      }
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), Colors.red, Colors.white);
    }
  }

  startCheckingOtp() async {
    //send post req to verify route.
    showDialog(
        context: Get.context!,
        builder: ((context) => const LoadingDialog(message: 'Please Wait')));
    log("User entered otp now checking otp => otp_controller.dart");
    //await getResponseFromStudentApi();
    if (otp.value.text.isNotEmpty) {
      await getResponseFromOTPApi();
      //hit api
      log('hitting otp verify route');
    } else {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: ((context) => const ErrorDialog(message: 'OTP is Empty')));
    }
  }
}
