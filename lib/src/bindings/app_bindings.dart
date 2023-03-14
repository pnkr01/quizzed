import 'package:get/get.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_login_controller.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_register_controller.dart';
import 'package:quiz/src/pages/home/student/controller/student_home_controller.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/controller/join_quiz_session_controller.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/join_quiz_controller.dart';
import 'package:quiz/src/pages/home/teacher/home/components/quiz_add/controller/quiz_addition_controller.dart';
import 'package:quiz/src/pages/home/teacher/home/controller/teacher_home_controller.dart';

import '../pages/auth/controller/otp_controller.dart';
import '../pages/home/student/home/components/joinQuiz/components/controller/detailed_view_controller.dart';
import '../pages/home/teacher/home/components/allQuiz/controller/draft_quiz_controller.dart';
import '../pages/home/teacher/home/components/allQuiz/controller/live_quiz_controller.dart';
import '../pages/home/teacher/home/components/allQuiz/design/controller/completed_controller.dart';
import '../pages/home/teacher/home/components/allQuiz/design/controller/expanded_quiz_ontap_controller.dart';
import '../pages/home/teacher/home/components/create/controller/create_quiz_controller.dart';
import '../pages/home/teacher/home/components/quiz_add/controller/quiz_view_screen_controller.dart';
import '../pages/home/teacher/profile/controller/teacher_profile_controller.dart';
import 'controller/starting_point_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StartingPointController());
    Get.lazyPut(() => CommonAuthLogInController(), fenix: true);
    Get.lazyPut(() => CommonAuthSignUpController(), fenix: true);
    Get.lazyPut(() => OTPController(), fenix: true);
    Get.lazyPut(() => StudentHomeController(), fenix: true);
    Get.lazyPut(() => JoinQuizCOntroller(), fenix: true);
    Get.lazyPut(() => TeacherHomeController(), fenix: true);
    Get.lazyPut(() => CreateQuizController(), fenix: true);
    Get.lazyPut(() => QuizAdditionController(), fenix: true);
    Get.lazyPut(() => AddQuizController(), fenix: true);
    Get.lazyPut(() => DraftQuizController(), fenix: true);
    Get.lazyPut(() => LiveQuizController(), fenix: true);
    Get.lazyPut(() => CompletedQuizController(), fenix: true);
    Get.lazyPut(() => TeacherProfileController(), fenix: true);
    Get.lazyPut(() => ExpadedQuizController(), fenix: true);
    Get.lazyPut(() => DetailedQuizController(), fenix: true);
    Get.lazyPut(() => JoinQuizSessionController(), fenix: true);
  }
}
