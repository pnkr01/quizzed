import 'package:get/get.dart';

class QuizAdditionController extends GetxController {
  dynamic argumentData = Get.arguments;

  //----------------------------Get------------------------------//
  getSubject() => argumentData[0]['subject'];
  getQuizId() => argumentData[1]['quiz_id'];
  getAuthor() => argumentData[2]['conducted_by'];
  getTitle() => argumentData[3]['title'];
  getSection() => argumentData[4]['section'];
  getSemester() => argumentData[5]['semester'];
  getDuration() => argumentData[6]['duration'];
  getCreatedAt() => argumentData[7]['created_at'];
  getStatus() => argumentData[8]['status'];
  getLastUpdate() => argumentData[9]['updated_at'];
  //------------------------------Close---------------------------//
}
