import 'package:get/get.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/home/teacher/home/components/create/create_quiz.dart';

class TeacherHomeController extends GetxController {
  String get teacherName => sharedPreferences.getString('tName') ?? 'Unknown';
  String get teacherEmail => sharedPreferences.getString('temail') ?? 'Unknown';
  String get teacherPhone => sharedPreferences.getString('tPhone') ?? 'Unknown';
  String get teacherRegdNo =>
      sharedPreferences.getString('tregdNo') ?? 'Unknown';

  navigateToCreateQuizScreen() {
    Get.toNamed(CreateQuiz.routeName);
  }
}
