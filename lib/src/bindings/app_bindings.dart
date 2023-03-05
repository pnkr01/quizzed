import 'package:get/get.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_login_controller.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_register_controller.dart';
import 'package:quiz/src/pages/home/student/controller/student_home_controller.dart';
import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/join_quiz_controller.dart';
import 'package:quiz/src/pages/home/teacher/home/controller/teacher_home_controller.dart';

import '../pages/auth/controller/otp_controller.dart';
import 'controller/starting_point_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StartingPointController(), permanent: true);
    Get.lazyPut(() => CommonAuthLogInController());
    Get.lazyPut(() => CommonAuthSignUpController());
    Get.lazyPut(() => OTPController());
    Get.lazyPut(() => StudentHomeController());
    Get.lazyPut(() => JoinQuizCOntroller());
    Get.lazyPut(() => TeacherHomeController());
  }
}
