import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/db/local/local_db.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';

import '../../../../../utils/errordialog.dart';
import '../../../../../utils/loading_dialog.dart';
import '../components/login/common_auth_login_screen.dart';

class OTPController extends GetxController {
  dynamic argumentData = Get.arguments;
  late Rx<TextEditingController> otp;
  @override
  void onInit() {
    print(argumentData);

    otp = TextEditingController().obs;
    super.onInit();
  }

  @override
  void onReady() {
    showMessageDialog();
    super.onReady();
  }

  getRegdNo() => argumentData[0]['regdNo'];
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

      if (response.statusCode == 201) {
        var res = jsonDecode(response.body);
        if (res['message'] != null) {
          Get.back();
          showSnackBar(res['message'], Colors.red, Colors.white);
        } else {
          log('send teacher to home page');
          // Teacher.fromJson(res);
          LocalDB.saveTeacherData(res);
          sharedPreferences.setBool('teacherLoggedIN', true);
          Get.offAllNamed(CommmonAuthLogInRoute.routeName);
          showSnackBar("Account validated Sucessfully, Please log In",
              Colors.green, Colors.white);
        }
      } else if (response.statusCode == 422) {
        showSnackBar("Account validated Sucessfully, Please log In",
            Colors.green, Colors.white);
      } else {
        throw Exception(response.body);
      }
      log(response.statusCode.toString());
      log(response.body);
    } catch (e) {
      print(e);
      showSnackBar(e.toString(), Colors.red, Colors.white);
    }
  }

  startCheckingOtp() async {
    //send post req to verify route.
    showDialog(
        context: Get.context!,
        builder: ((context) => const LoadingDialog(message: 'Please Wait')));
    log("OTP Screen");
    //await getResponseFromStudentApi();
    if (otp.value.text.isNotEmpty) {
      await getResponseFromOTPApi();
      //hit api
      log('hit otp route');
    } else {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: ((context) => const ErrorDialog(message: 'OTP is Empty')));
    }
  }
}
