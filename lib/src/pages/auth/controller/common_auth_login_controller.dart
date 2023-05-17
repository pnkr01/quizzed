import 'dart:convert';
import 'package:device_imei/device_imei.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/db/firebase/firebase_helper.dart';
import 'package:quiz/src/db/local/local_db.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/auth/components/signup/common_auth_sign_up_screen.dart';
import 'package:quiz/src/pages/home/student/home/student_home.dart';
import 'package:quiz/src/pages/home/teacher/teacher_home.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../utils/errordialog.dart';
import '../components/otp/otp_screen.dart';

class CommonAuthLogInController extends GetxController {
  late Rx<TextEditingController> regdNo;
  late Rx<TextEditingController> password;
  late TextEditingController forgotRegd;
  RxBool isStartedLogginIn = false.obs;
  final FocusNode focusNodeRegdNo = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  @override
  void onInit() {
    regdNo = TextEditingController().obs;
    password = TextEditingController().obs;
    forgotRegd = TextEditingController();
    super.onInit();
  }

  clearLogInField() {
    regdNo.value.clear();
    password.value.clear();
  }

  forgotHelper() async {
    quizDebugPrint('starting');
    var response = await https.get(
      Uri.parse(
          ApiConfig.getEndPointsUrl('auth/request-regd-no/${forgotRegd.text}')),
    );
    var decode = jsonDecode(response.body);
    quizDebugPrint(response.body);
    if (decode["message"].toString().contains('User found.')) {
      showDialog(
        context: Get.context!,
        builder: ((context) => AlertDialog(
                  content: Text(
                    "Your registration number is : ${decode["regdNo"]}",
                    style: kBodyText3Style().copyWith(color: blackColor),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          await Clipboard.setData(
                              ClipboardData(text: decode["regdNo"]));
                          Get.back();
                          Get.back();
                          showSnackBar(
                              'Copied ${decode["regdNo"]} to clipboard',
                              greenColor,
                              whiteColor);
                          forgotRegd.clear();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kTeacherPrimaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.copy_rounded,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Center(
                                child: Text(
                              "Copy",
                              style: kBodyText3Style(),
                            )),
                          ],
                        )),
                  ],
                )

            // ErrorDialog(
            //       color: kTeacherPrimaryColor,
            //       message: 'Your Registration number is ${decode["regdNo"]}',
            //     )

            ),
      );
    } else {
      Get.back();
      Get.back();
      forgotRegd.clear();
      showDialog(
          context: Get.context!,
          builder: ((context) => ErrorDialog(
                message: decode["message"],
                color: kTeacherPrimaryColor,
              )));
    }
  }

  setCookie(response) async {
    String rawCookie = response.headers['set-cookie']!;
    int index = rawCookie.indexOf(';');
    String refreshToken =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
    int idx = refreshToken.indexOf("=");
    if (kDebugMode) {
      print(refreshToken.substring(idx + 1).trim());
    }
    String cookieID = refreshToken.substring(idx + 1).trim();
    sharedPreferences.setString('Scookie', cookieID);
    quizDebugPrint("Cookieeeeee  $cookieID");
  }

  navigateToSignUpScreen() {
    clearLogInField();
    Get.toNamed(CommomAuthSignUpScreen.routeName);
  }

  setLocalIndex(var res) async {
    await LocalDB.saveStudentModel(res);
    sharedPreferences.setBool('studentLogged', true);
  }

  saveTeacherIndex(var res) async {
    await LocalDB.saveTeacherData(res);
    sharedPreferences.setBool('teacherLoggedIN', true);
  }

  navigateToteacherHomePage() {
    Get.offAllNamed(TeacherHome.routeName);
    showSnackBar("Sucessfully logged In", Colors.green, Colors.white);
  }

  hitLoginApi(String imei) async {
    var response = await https.post(
      Uri.parse(ApiConfig.getEndPointsUrl('auth/login')),
      body: {
        "regdNo": regdNo.value.text,
        "password": password.value.text,
      },
    );
    quizDebugPrint(response.statusCode.toString());
    var res = jsonDecode(response.body);
    if (response.statusCode == 201) {
      quizDebugPrint("connection created");
      if (res["name"] != null && res["type"] == "student") {
        quizDebugPrint(
            'pass and regd no verified => sending to student home page');
        quizDebugPrint('saving user cookie');
        await setCookie(response);
        isStartedLogginIn.value = false;

        //save this user regdNo-imei
        //manitain a imei bucket imei-regdNo

        if (await MyFirebase().isUserAlreadyExist(regdNo.value.text)) {
          if (await MyFirebase().checkRegdNoWithImei(regdNo.value.text) ==
              imei)
               {
                quizDebugPrint("all check passed 172");
                Get.offAllNamed(StudentHome.routeName);
                await setLocalIndex(res);
                showSnackBar("Sucessfully logged In", Colors.green, Colors.white);
                } else {
                isStartedLogginIn.value = false;
               showDialog(
               barrierDismissible: false,
               context: Get.context!,
               builder: (context) => AlertDialog(
                content: Column(
                  children: [
                    const Text(
                      'Your IMEI number mismatch, contact CDC Admin for resolution',
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Get.until((route) => route.isFirst);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          //studet absent in firebase.
          //save user data in firebase and send user data to firebase.

          //check if same imei is there in imei collection?

          if (await MyFirebase().isThisImeiAlreadyExist(imei)) {
            isStartedLogginIn.value = false;
            showDialog(
              barrierDismissible: false,
              context: Get.context!,
              builder: (context) => AlertDialog(
                content: Column(
                  children: [
                    const Text(
                      'This Device is not available for your registartion No. Contact CDC if this is error',
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Get.until((route) => route.isFirst);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            await MyFirebase()
                .saveRegdNoWithImei(regdNo.value.text, imei)
                .then((value) async {
              quizDebugPrint("all check passed 172");
              Get.offAllNamed(StudentHome.routeName);
              await setLocalIndex(res);
              showSnackBar("Sucessfully logged In", Colors.green, Colors.white);
            });
          }
        }
      } else if (res["type"] == "teacher" && res["status"] == "active") {
        quizDebugPrint('tecaher data available=> save this and log in');
        await saveTeacherIndex(res);
        await setTeacherCookie(response);
        isStartedLogginIn.value = false;
        navigateToteacherHomePage();
      } else {
        isStartedLogginIn.value = false;
        quizDebugPrint('else part of login screen');
        showSnackBar(res["message"], Colors.red, Colors.white);
      }
    } else if (response.statusCode == 404) {
      isStartedLogginIn.value = false;
      showSnackBar("Please signup then login", Colors.red, Colors.white);
    } else if (res["error"] == "Unauthorized" &&
        res["message"]
            .toString()
            .contains('Your account is not verified yet')) {
      quizDebugPrint('inactive teacher.');
      quizDebugPrint('sending => to otp screen');
      isStartedLogginIn.value = false;
      Get.toNamed(
        OTPScreen.routeName,
        arguments: [
          {"regdNo": regdNo.value.text},
          {"message": res["message"]},
        ],
      );
    } else {
      isStartedLogginIn.value = false;
      showSnackBar(res["message"], Colors.red, Colors.white);
    }
  }

  checkIMEIPermission() async {
    PermissionStatus phone = await Permission.phone.status;
    if (phone.isDenied) {
      await Permission.phone.request();
      if (await Permission.phone.status.isGranted) {
        String? imei = await DeviceImei().getDeviceImei();
        if (imei != null) {
          checkForErrorAndStartLoggingInUser(imei);
        }
      }
    } else {
      String? imei = await DeviceImei().getDeviceImei();
      if (imei != null) {
        checkForErrorAndStartLoggingInUser(imei);
      }
    }
  }

  checkForErrorAndStartLoggingInUser(String imei) {
    quizDebugPrint(regdNo.value.text);
    quizDebugPrint(password.value.text);
    if (regdNo.value.text.isNotEmpty && password.value.text.isNotEmpty) {
      quizDebugPrint('hitting login Api');
      try {
        hitLoginApi(imei);
      } catch (e) {
        isStartedLogginIn.value = false;
        showSnackBar(e.toString(), Colors.red, Colors.white);
      }
    } else {
      isStartedLogginIn.value = false;
      showDialog(
          context: Get.context!,
          builder: ((context) =>
              const ErrorDialog(message: 'fill all details')));
    }
  }
}
