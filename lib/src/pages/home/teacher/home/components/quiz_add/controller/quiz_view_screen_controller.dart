import 'package:get/get.dart';

import '../quiz_additon_view_screen.dart';

class QuizAdditionController extends GetxController {
  dynamic argumentData = Get.arguments;

  //----------------------------Get arguments start------------------------------//
  getSubject() => argumentData[0]['subject'];
  getQuizId() => argumentData[1]['quiz_id'];
  getAuthor() => argumentData[2]['conducted_by'];
  getTitle() => argumentData[3]['title'];
  getSection() => argumentData[4]['section'];
  getSemester() => argumentData[5]['semester'];
  getDuration() => argumentData[6]['duration'];
  getCreatedAt() => argumentData[7]['created_at'];
  getLastUpdate() => argumentData[8]['updated_at'];
  getStatus() => argumentData[9]['status'];
  getDescription() => argumentData[10]['description'];
  getTotalQs() => argumentData[11]['total_questions'];
  getMarksPerQs() => argumentData[12]['per_question_marks'];
  getSubjectCode() => argumentData[13]['subjectCode'];
  //------------------------------Close---------------------------//

  navigateToQuizCreatePage() {
    Get.toNamed(QuizAdditionView.routeName, arguments: [
      {"quizBucketID": getQuizId()},
      {"subject": getSubject()},
      {"totalQs": getTotalQs()},
      {"subjectCode": getSubjectCode()},
    ]);
  }
}
