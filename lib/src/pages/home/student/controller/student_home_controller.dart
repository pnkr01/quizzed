import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/global/shared.dart';
import 'package:quizzed/src/pages/home/student/home/components/joinQuiz/join_quiz_view.dart';
import 'package:quizzed/src/pages/home/student/home/components/result/quiz_result_view.dart';

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
    if (await FlutterDnd.isNotificationPolicyAccessGranted == true) {
      bool? isAllowed = await FlutterDnd.setInterruptionFilter(
          FlutterDnd.INTERRUPTION_FILTER_NONE);
      quizDebugPrint(isAllowed);
      if (isAllowed == true && isAllowed != null) {
        navigateToJoinQuiz();
      }
    } else {
      FlutterDnd.gotoPolicySettings();
    }
  }
}
