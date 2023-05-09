import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/db/local/local_db.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import '../../../../../../../model/student_profile_model.dart';

class StudentProfileController extends GetxController {
  late List<StudentProfileModel> profile;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    profile = [];
    tryFetchingProfile();
    super.onInit();
  }

  tryFetchingProfile() {
    try {
      _fetchProfile();
    } catch (e) {
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      LocalDB.removeLoacalDb();
      showSnackBar('Session Expired :(', blackColor, whiteColor);
    }
  }

  _fetchProfile() async {
    var res = await https.get(Uri.parse(ApiConfig.getEndPointsUrl('auth/self')),
        headers: {
          'Cookie': "Authentication=${sharedPreferences.getString('Scookie')}"
        });
    var decodeResponse = await jsonDecode(res.body);
    quizDebugPrint(decodeResponse);
    if (decodeResponse["message"] != null) {
      quizDebugPrint('cookie refreshing needed =====> Refreshing cookie.....');
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      showSnackBar(
          'Your Session is expired. Login Again..', greenColor, whiteColor);
      LocalDB.removeLoacalDb();
    }
    // print(decodeResponse);
    profile.add(StudentProfileModel.fromJson(decodeResponse));
    if (profile.isNotEmpty) {
      isLoading.value = true;
      //print(profile[0].admissionYear);
    }
  }
}
