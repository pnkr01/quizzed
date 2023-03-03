import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JoinQuizCOntroller extends GetxController {
  late Rx<TextEditingController> quizID;
  RxBool isTapStartJoining = false.obs;

  bool get showLoading => isTapStartJoining.value;
  @override
  void onInit() {
    quizID = TextEditingController().obs;
    super.onInit();
  }

  checkThisQuizID() {}
}
