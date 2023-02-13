import 'package:get/get.dart';
import 'package:quiz/src/pages/auth/common/controller/common_auth_login_controller.dart';
import 'package:quiz/src/pages/auth/common/controller/common_auth_register_controller.dart';

import '../pages/auth/common/controller/otp_controller.dart';
import 'controller/starting_point_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StartingPointController(), permanent: true);
    Get.put(CommonAuthLogInController());
    Get.put(CommonAuthSignUpController());
    Get.lazyPut(() => OTPController());
  }
}
