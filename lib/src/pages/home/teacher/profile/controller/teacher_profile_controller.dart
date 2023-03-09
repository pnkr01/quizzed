import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';

import '../../../../../global/shared.dart';

class TeacherProfileController extends GetxController {
  RxBool isFetching = true.obs;

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
    print(decoded);
    // if (decoded["message"] == "Unauthorized") {
    //   Get.offAllNamed(CommmonAuthLogInRoute.routeName);
    //   LocalDB.removeLoacalDb();
    // }
  }
}
