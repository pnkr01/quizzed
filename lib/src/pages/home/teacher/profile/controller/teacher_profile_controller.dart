import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quizzed/src/api/points.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/model/teacher_profile_model.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';

import '../../../../../db/local/local_db.dart';
import '../../../../../global/shared.dart';
import '../../../../auth/components/login/common_auth_login_screen.dart';

class TeacherProfileController extends GetxController {
  RxBool isFetching = true.obs;

  List<TeacherProfileModel> profileList = [];
  List<String> title = ["RegdNo", "Email", "Created at", "Phone", "Updated At"];

  List<Color> color = [
    redColor,
    greenColor,
    Colors.teal,
    Colors.purple,
    Colors.red,
    Colors.amber,
    Colors.orange
  ];
  List<String> subject = [
    "IDB",
    "CNS",
    "ISUP",
    "AD-2",
    "AD-1",
    "CSW-1",
    "CSW-2",
  ];
  List<String> sec = [
    "CSE-A",
    "CSE-B",
    "CSE-C",
    "CSE-D",
    "CSE-E",
    "CSE-F",
    "CSE-G",
    "CSE-H",
    "CSE-I",
  ];

  @override
  void onInit() {
    fetchMyProfile();
    super.onInit();
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': "Authentication=${sharedPreferences.getString('Tcookie')}"
  };

  fetchMyProfile() async {
    var response = await https.get(
        Uri.parse(ApiConfig.getEndPointsUrl('auth/self')),
        headers: headers);
    var decoded = jsonDecode(response.body);
    if (decoded["message"] == "Unauthorized") {
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      LocalDB.removeLoacalDb();
      showSnackBar(decoded["message"], redColor, whiteColor);
    }
    print(decoded);
    profileList.add(TeacherProfileModel.fromJson(decoded));
    Future.delayed(const Duration(milliseconds: 80), () {
      isFetching.value = false;
    });
  }
}
