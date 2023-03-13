import 'package:get/get.dart';

class DetailedQuizController extends GetxController {
  RxBool isLoading = true.obs;
  dynamic arguments = Get.arguments;

  @override
  void onInit() {
    makeThisCall();
    super.onInit();
  }

  makeThisCall() {
    //fetch Data
    print(arguments[0]);
  }
}
