import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/join_quiz_view.dart';
import 'package:quiz/src/pages/home/student/home/components/result/quiz_result_view.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

class StudentHomeController extends GetxController {
  //--------------------Student Details------------------------------------------------------//
  String getStudentName() => sharedPreferences.getString('name') ?? "";
  String getStudentregdNo() => sharedPreferences.getString('regdNo') ?? "";
  String getStudentPhone() => sharedPreferences.getString('phone') ?? "";
  //------------------------Ends---------------------------------------------------------//

  //------------------------Join Quiz------------------------------//
  navigateToJoinQuiz() {
    Get.toNamed(JoinQuizView.routeName);
  }

  //------------------------Result Quiz------------------------------//
  navigateToResultQuiz() {
    Get.toNamed(QuizResultView.routeName);
  }

  //-----------------DND-------------------//
  checkDND() async {
    // Check if DND mode is supported on the current device
    bool? isSupported = await FlutterDnd.isNotificationPolicyAccessGranted;

    if (isSupported == true && isSupported != null) {
      // Check if the user has granted permission to access DND settings
      bool? hasPermission = await FlutterDnd.isNotificationPolicyAccessGranted;

      if (hasPermission == true && hasPermission != null) {
        // Enable DND mode
        bool? isDone = await FlutterDnd.setInterruptionFilter(
            FlutterDnd.INTERRUPTION_FILTER_NONE);
        quizDebugPrint(isDone);
        if (isDone == true && isDone != null) {
          navigateToJoinQuiz();
        }
      } else {
        // Redirect the user to grant permission
        FlutterDnd.gotoPolicySettings();
      }
    } else {
      showSnackBar("DND is not available", redColor, whiteColor);
    }
  }
}
