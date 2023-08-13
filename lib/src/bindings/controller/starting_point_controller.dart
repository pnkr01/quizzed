import 'dart:async';
import 'package:get/get.dart';
import 'package:quizzed/src/db/firebase/firebase_helper.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/pages/home/student/home/student_home.dart';
import '../../global/shared.dart';
import '../../pages/auth/components/login/common_auth_login_screen.dart';
import '../../pages/home/teacher/teacher_home.dart';
import '../../update/update_page.dart';

class StartingPointController extends GetxController {
  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  startTimer() {
    Timer(const Duration(seconds: 2), () {
      takeDecision();
    });
  }

  void startUpdatehandler() async {
    //take link and pass it to download and install function
    String updateUrl = await getUpdateLink();
    quizDebugPrint("update url is $updateUrl");
    Get.offAll(() => UpdateScreenPage(
          apkUrl: updateUrl,
        ));
  }

  Future<String> getUpdateLink() {
    return MyFirebase.versionCollection
        .doc('version')
        .get()
        .then((value) => value["link"]);
  }

  takeDecision() async {
    bool isUpdateAvailable = await checkVersion();
    if (isUpdateAvailable) {
      startUpdatehandler();
    } else {
      if (sharedPreferences.getBool('studentLogged') != null) {
        navigateToStudentHome();
      } else if (sharedPreferences.getBool('teacherLoggedIN') != null) {
        navigateToTeacherHome();
      } else {
        navigateToCommonAuthScreen();
      }
    }
  }

  checkVersion() async {
    String firebaseVersion = await MyFirebase().checkForNewVersion();
    quizDebugPrint("firebase version is $firebaseVersion");
    bool isUpdateAvailable = firebaseVersion == version ? false : true;
    quizDebugPrint("current version is $version");
    quizDebugPrint("is update required? $isUpdateAvailable");
    return isUpdateAvailable;
  }

  navigateToStudentHome() {
    //send to home page
    Get.offAllNamed(StudentHome.routeName);
  }

  navigateToTeacherHome() {
    //send to home page
    Get.offAllNamed(TeacherHome.routeName);
  }

  navigateToCommonAuthScreen() {
    //send to auth page
    Get.offNamed(CommmonAuthLogInRoute.routeName);
  }
}
