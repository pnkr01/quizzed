import 'package:get/get.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_login_controller.dart';
import 'package:quiz/src/pages/auth/controller/common_auth_register_controller.dart';

import '../pages/auth/controller/otp_controller.dart';
import 'controller/starting_point_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StartingPointController(), permanent: true);
    Get.lazyPut(() => CommonAuthLogInController());
    Get.lazyPut(() => CommonAuthSignUpController());
    Get.lazyPut(() => OTPController());
  }
}
