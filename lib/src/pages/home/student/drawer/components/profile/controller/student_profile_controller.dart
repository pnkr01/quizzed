import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quizzed/src/api/points.dart';
import 'package:quizzed/src/db/local/local_db.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/global/shared.dart';
import 'package:quizzed/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';
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
