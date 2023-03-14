import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JoinQuizSessionController extends GetxController {
  final PageController pageController = PageController();
  RxInt currentIdx = 0.obs;

  onPageChanged(newVal) {
    print(newVal);
    currentIdx.value = newVal;
  }
}
