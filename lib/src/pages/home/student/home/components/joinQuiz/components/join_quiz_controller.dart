import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JoinQuizCOntroller extends GetxController {
  late Rx<TextEditingController> quizID;
  @override
  void onInit() {
    quizID = TextEditingController().obs;
    super.onInit();
  }

  checkThisQuizID(){
    
  }
}
