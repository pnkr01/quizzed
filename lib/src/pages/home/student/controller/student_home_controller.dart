import 'package:get/get.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/join_quiz_view.dart';
import 'package:quiz/src/pages/home/student/home/components/result/quiz_result_view.dart';

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
}
